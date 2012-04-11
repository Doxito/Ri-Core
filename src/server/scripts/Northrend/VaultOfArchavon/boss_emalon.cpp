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
#include "vault_of_archavon.h"

//Emalon spells
enum Spells
{
    SPELL_OVERCHARGE            = 64218,    // Cast every 45 sec on a random Tempest Minion
    SPELL_BERSERK               = 26662,

    SPELL_SHOCK                 = 64363,
    SPELL_OVERCHARGED           = 64217,
    SPELL_OVERCHARGED_BLAST     = 64219,    // Cast when Overcharged reaches 10 stacks. Mob dies after that
    SPELL_WARDER_OVERCHARGE     = 64379
};

// cannot let SpellDifficulty handle it, no entries for these
#define SPELL_CHAIN_LIGHTNING           RAID_MODE(64213, 64215)
#define SPELL_LIGHTNING_NOVA            RAID_MODE(64216, 65279)

enum BossEmotes
{
    EMOTE_OVERCHARGE        = -1590000,
    EMOTE_MINION_RESPAWN    = -1590001,
    EMOTE_BERSERK           = -1590002,
};

enum Events
{
    EVENT_CHAIN_LIGHTNING   = 1,
    EVENT_LIGHTNING_NOVA    = 2,
    EVENT_OVERCHARGE        = 3,
    EVENT_BERSERK           = 4,
    EVENT_SHOCK             = 5,
};

//Creatures
#define MOB_TEMPEST_MINION          33998

#define MAX_TEMPEST_MINIONS         4

struct Position TempestMinions[MAX_TEMPEST_MINIONS] =
{
    {-203.980103f, -281.287720f, 91.650223f, 1.598807f},
    {-233.489410f, -281.139282f, 91.652412f, 1.598807f},
    {-233.267578f, -297.104645f, 91.681915f, 1.598807f},
    {-203.842529f, -297.097015f, 91.745163f, 1.598807f}
};

/*######
##  Emalon the Storm Watcher
######*/
class boss_emalon : public CreatureScript
{
    public:
        boss_emalon() : CreatureScript("boss_emalon") { }

        struct boss_emalonAI : public BossAI
        {
            boss_emalonAI(Creature* creature) : BossAI(creature, DATA_EMALON)
            {
            }

            void Reset()
            {
                _Reset();

                for (uint8 i = 0; i < MAX_TEMPEST_MINIONS; ++i)
                    me->SummonCreature(MOB_TEMPEST_MINION, TempestMinions[i], TEMPSUMMON_CORPSE_DESPAWN, 0);
            }

            void JustSummoned(Creature* summoned)
            {
                BossAI::JustSummoned(summoned);

                // AttackStart has NULL-check for victim
                if (summoned->AI())
                    summoned->AI()->AttackStart(me->getVictim());
            }

            void EnterCombat(Unit* who)
            {
                if (!summons.empty())
                {
                    for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    {
                        Creature* minion = Unit::GetCreature(*me, *itr);
                        if (minion && minion->isAlive() && !minion->getVictim() && minion->AI())
                            minion->AI()->AttackStart(who);
                    }
                }

                events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 5000);
                events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 40000);
                events.ScheduleEvent(EVENT_BERSERK, 360000);
                events.ScheduleEvent(EVENT_OVERCHARGE, 45000);

                _EnterCombat();
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                _DoAggroPulse(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_CHAIN_LIGHTNING:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_CHAIN_LIGHTNING);
                            events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, urand(10000, 12000));
                            break;
                        case EVENT_LIGHTNING_NOVA:
                            DoCastAOE(SPELL_LIGHTNING_NOVA);
                            events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 40000);
                            break;
                        case EVENT_OVERCHARGE:
                            DoCast(SPELL_OVERCHARGE);
                            DoScriptText(EMOTE_OVERCHARGE, me);
                            events.ScheduleEvent(EVENT_OVERCHARGE, 45000);
                           break;
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK, true);
                            DoScriptText(EMOTE_BERSERK, me);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_emalonAI(creature);
        }
};

/*######
##  Tempest Minion
######*/
class mob_tempest_minion : public CreatureScript
{
    public:
        mob_tempest_minion() : CreatureScript("mob_tempest_minion") { }

        struct mob_tempest_minionAI : public ScriptedAI
        {
            mob_tempest_minionAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                _events.Reset();
            }

            void JustDied(Unit* /*Killer*/)
            {
                if (!me->isSummon())
                    return;

                if (Creature* emalon = Unit::GetCreature(*me, _instance ? _instance->GetData64(DATA_EMALON) : 0))
                {
                    if (emalon->isAlive())
                    {
                        emalon->SummonCreature(MOB_TEMPEST_MINION, *emalon, TEMPSUMMON_CORPSE_DESPAWN, 0);
                        DoScriptText(EMOTE_MINION_RESPAWN, me);
                    }
                }
            }

            void EnterCombat(Unit* who)
            {
                DoZoneInCombat();
                _events.ScheduleEvent(EVENT_SHOCK, urand(10000, 20000));

                if (!me->isSummon())
                    return;

                if (Creature* emalon = Unit::GetCreature(*me, _instance ? _instance->GetData64(DATA_EMALON) : 0))
                {
                    if (!emalon->getVictim() && emalon->AI())
                        emalon->AI()->AttackStart(who);
                }
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (!me->isSummon() && HealthBelowPct(40) && !me->HasAura(SPELL_WARDER_OVERCHARGE))
                    DoCast(me, SPELL_WARDER_OVERCHARGE, true);

                if (me->GetAuraCount(SPELL_OVERCHARGED) >= 10)
                {
                    DoCast(me, SPELL_OVERCHARGED_BLAST);
                    me->DealDamage(me, me->GetHealth());
                }

                if (_events.ExecuteEvent() == EVENT_SHOCK)
                {
                    DoCastVictim(SPELL_SHOCK);
                    _events.ScheduleEvent(EVENT_SHOCK, urand(17500, 22500));
                }

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* _instance;
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_tempest_minionAI(creature);
        }
};

class spell_overcharge_targeting : public SpellScriptLoader
{
    public:
        spell_overcharge_targeting() : SpellScriptLoader("spell_overcharge_targeting") { }

        class spell_overcharge_targeting_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_overcharge_targeting_SpellScript);

            void FilterTargetsInitial(std::list<Unit*>& unitList)
            {
                if (unitList.empty())
                    return;

                std::list<Unit*>::iterator itr = unitList.begin();
                std::advance(itr, urand(0, unitList.size() - 1));
                Unit* target = *itr;
                unitList.clear();
                unitList.push_back(target);
                _target = target;
            }

            void FilterTargetsSubsequent(std::list<Unit*>& unitList)
            {
                unitList.clear();
                if (_target)
                    unitList.push_back(_target);
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_overcharge_targeting_SpellScript::FilterTargetsInitial, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_overcharge_targeting_SpellScript::FilterTargetsSubsequent, EFFECT_1, TARGET_UNIT_SRC_AREA_ENTRY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_overcharge_targeting_SpellScript::FilterTargetsSubsequent, EFFECT_2, TARGET_UNIT_SRC_AREA_ENTRY);
            }

            Unit* _target;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_overcharge_targeting_SpellScript();
        }
};

class spell_emalon_lightning_nova : public SpellScriptLoader
{
    public:
        spell_emalon_lightning_nova() : SpellScriptLoader("spell_emalon_lightning_nova") { }

        class spell_emalon_lightning_nova_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_emalon_lightning_nova_SpellScript);

            void CalcDamage()
            {
                if (!GetHitUnit() || !GetCaster())
                    return;

                float distance = GetHitUnit()->GetExactDist2d(GetCaster());
                if (distance < 10.0f)
                    return;

                SetHitDamage(int32(GetHitDamage() * 10 / distance));
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_emalon_lightning_nova_SpellScript::CalcDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_emalon_lightning_nova_SpellScript();
        }
};

void AddSC_boss_emalon()
{
    new boss_emalon();
    new mob_tempest_minion();
    new spell_overcharge_targeting();
    new spell_emalon_lightning_nova();
}
