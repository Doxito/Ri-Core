/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptPCH.h"
#include "naxxramas.h"

#define SPELL_MORTAL_WOUND         25646
#define SPELL_ENRAGE               RAID_MODE(28371,54427)
#define SPELL_DECIMATE             RAID_MODE(28374,54426)
#define SPELL_BERSERK              26662
#define SPELL_INFECTED_WOUND       29307
#define SPELL_INFECTED_TRIGGERED   29306

#define MOB_ZOMBIE  16360

const Position PosSummon[3] =
{
    {3267.9f, -3172.1f, 297.42f, 0.94f},
    {3253.2f, -3132.3f, 297.42f, 0},
    {3308.3f, -3185.8f, 297.42f, 1.58f},
};

enum Events
{
    EVENT_WOUND = 1,
    EVENT_ENRAGE,
    EVENT_DECIMATE,
    EVENT_BERSERK,
    EVENT_SUMMON
};

#define EMOTE_NEARBY    " spots a nearby zombie to devour!"

class boss_gluth : public CreatureScript
{
public:
    boss_gluth() : CreatureScript("boss_gluth") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_gluthAI (creature);
    }

    struct boss_gluthAI : public BossAI
    {
        boss_gluthAI(Creature* c) : BossAI(c, BOSS_GLUTH)
        {
            // Do not let Gluth be affected by zombies' debuff
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_INFECTED_TRIGGERED, true);
        }

        void Reset()
        {
            _Reset();
        }

        void AttackGluth(Creature* who)
        {
            who->SetReactState(REACT_PASSIVE);
            who->AddThreat(me, 9999999);
            who->AI()->AttackStart(me);
            who->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            who->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->ToCreature() && who->ToCreature()->GetEntry() == MOB_ZOMBIE && me->IsWithinDistInMap(who, 7))
            {
                AttackStart(who);
                me->SetReactState(REACT_PASSIVE);
                AttackGluth(who->ToCreature());

                // TODO: use a script text
                me->MonsterTextEmote(EMOTE_NEARBY, 0, true);
            }
            else if (!me->isInCombat() && who->ToPlayer() && who->GetPositionZ() < me->GetPositionZ() + 10.0f && me->IsWithinLOSInMap(who))
                AttackStart(who);
            else
                BossAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_WOUND, 10000);
            events.ScheduleEvent(EVENT_ENRAGE, 15000);
            events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000, 90000));
            events.ScheduleEvent(EVENT_BERSERK, RAID_MODE(8*60000, 7*60000));
            events.ScheduleEvent(EVENT_SUMMON, 15000);
        }

        void JustSummoned(Creature* summon)
        {
            if (summon->GetEntry() == MOB_ZOMBIE)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    summon->AI()->AttackStart(target);

                me->SetInCombatWith(summon);
                summon->SetInCombatWith(me);
                me->AddThreat(summon, 0.0f);
            }

            //summon->CastSpell(summon,SPELL_INFECTED_WOUND,true);
            summons.Summon(summon);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictimWithGaze() || !CheckInRoom())
                return;

            // temporary
            if (me->GetDistance(me->GetHomePosition()) > 80.0f)
            {
                EnterEvadeMode();
                return;
            }

            _DoAggroPulse(diff);
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WOUND:
                        DoCastVictim(SPELL_MORTAL_WOUND);
                        events.ScheduleEvent(EVENT_WOUND, 10000);
                        break;
                    case EVENT_ENRAGE:
                        // TODO : Add missing text
                        DoCast(me, SPELL_ENRAGE);
                        events.ScheduleEvent(EVENT_ENRAGE, 15000);
                        break;
                    case EVENT_DECIMATE:
                        // TODO : Add missing text
                        DoCastAOE(SPELL_DECIMATE);
                        events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000, 90000));
                        for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        {
                            Creature* minion = Unit::GetCreature(*me, *itr);
                            if (minion && minion->isAlive())
                                AttackGluth(minion);
                        }
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_SUMMON:
                        for (int32 i = 0; i < RAID_MODE(1, 2); ++i)
                            DoSummon(MOB_ZOMBIE, PosSummon[RAID_MODE(0, rand() % 3)], 10*MINUTE*IN_MILLISECONDS, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN);
                        events.ScheduleEvent(EVENT_SUMMON, 10000);
                        break;
                }
            }

            if (me->getVictim() && me->getVictim()->GetEntry() == MOB_ZOMBIE)
            {
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    me->Kill(me->getVictim());
                    me->ModifyHealth(int32(me->CountPctFromMaxHealth(5)));
                }
            }
            else
                DoMeleeAttackIfReady();
        }
    };
};

// just to prevent infected wound from not stacking, TODO: remove if core-fixed
class mob_gluth_zombie : public CreatureScript
{
public:
    mob_gluth_zombie() : CreatureScript("mob_gluth_zombie") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_gluth_zombieAI(creature);
    }

    struct mob_gluth_zombieAI : public ScriptedAI
    {
        mob_gluth_zombieAI(Creature* c) : ScriptedAI(c) { }

        void DamageDealt(Unit* victim, uint32 &damage, DamageEffectType /*damagetype*/)
        {
            uint8 stackcount = 0;

            if (victim->HasAura(SPELL_INFECTED_TRIGGERED)) // if aura exists
            {
                 if (Aura* infectedAura = victim->GetAura(SPELL_INFECTED_TRIGGERED))
                 {
                     stackcount = infectedAura->GetStackAmount();
                     if (stackcount < 99)
                         infectedAura->SetStackAmount(stackcount + 1); // add one stack
                     infectedAura->SetDuration(infectedAura->GetMaxDuration()); // reset aura duration
                 }
            }
            else
                DoCast(victim, SPELL_INFECTED_TRIGGERED);  // else add aura
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_gluth()
{
    new boss_gluth();
    new mob_gluth_zombie();
}
