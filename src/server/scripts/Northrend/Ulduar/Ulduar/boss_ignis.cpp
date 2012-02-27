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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ulduar.h"
#include "Vehicle.h"

// TODO: remove the Grab Hack

enum Yells
{
    SAY_AGGRO                     = -1603220,
    SAY_SLAY_1                    = -1603221,
    SAY_SLAY_2                    = -1603222,
    SAY_DEATH                     = -1603223,
    SAY_SUMMON                    = -1603224,
    SAY_SLAG_POT                  = -1603225,
    SAY_SCORCH_1                  = -1603226,
    SAY_SCORCH_2                  = -1603227,
    SAY_BERSERK                   = -1603228,
    EMOTE_JETS                    = -1603229
};

enum Spells
{
    // Ignis
    SPELL_FLAME_JETS              = 62680,
    SPELL_SCORCH                  = 62546,
    SPELL_SLAG_POT                = 62717,
    SPELL_SLAG_POT_DAMAGE         = 65722,
    SPELL_SLAG_IMBUED             = 62836,
    SPELL_ACTIVATE_CONSTRUCT      = 62488,
    SPELL_STRENGTH                = 64473,
    SPELL_GRAB                    = 62707,
    SPELL_BERSERK                 = 47008,
    SPELL_GRAB_ENTER_VEHICLE      = 62711,

    // Constructs
    SPELL_HEAT                    = 65667,
    SPELL_MOLTEN                  = 62373,
    SPELL_BRITTLE                 = 62382,
    SPELL_BRITTLE_25              = 67114,
    SPELL_SHATTER                 = 62383,
    SPELL_FREEZE_ANIM             = 63354,

    // Ground
    SPELL_GROUND                  = 62548
};

enum Events
{
    EVENT_JET                     = 1,
    EVENT_SCORCH,
    EVENT_SLAG_POT,
    EVENT_GRAB_POT,
    EVENT_CHANGE_POT,
    EVENT_CONSTRUCT,
    EVENT_BERSERK,

    ACTION_REMOVE_BUFF,

    DATA_SHATTERED
};

enum Creatures
{
    NPC_IRON_CONSTRUCT            = 33121,
    NPC_GROUND_SCORCH             = 33221
};

enum AchievementData
{
    ACHIEVEMENT_TIMED_START_EVENT = 20951
};

Position const Pos[20] =
{
    {630.366f, 216.772f, 360.891f, 3.001970f},
    {630.594f, 231.846f, 360.891f, 3.124140f},
    {630.435f, 337.246f, 360.886f, 3.211410f},
    {630.493f, 313.349f, 360.886f, 3.054330f},
    {630.444f, 321.406f, 360.886f, 3.124140f},
    {630.366f, 247.307f, 360.888f, 3.211410f},
    {630.698f, 305.311f, 360.886f, 3.001970f},
    {630.500f, 224.559f, 360.891f, 3.054330f},
    {630.668f, 239.840f, 360.890f, 3.159050f},
    {630.384f, 329.585f, 360.886f, 3.159050f},
    {543.220f, 313.451f, 360.886f, 0.104720f},
    {543.356f, 329.408f, 360.886f, 6.248280f},
    {543.076f, 247.458f, 360.888f, 6.213370f},
    {543.117f, 232.082f, 360.891f, 0.069813f},
    {543.161f, 305.956f, 360.886f, 0.157080f},
    {543.277f, 321.482f, 360.886f, 0.052360f},
    {543.316f, 337.468f, 360.886f, 6.195920f},
    {543.280f, 239.674f, 360.890f, 6.265730f},
    {543.265f, 217.147f, 360.891f, 0.174533f},
    {543.256f, 224.831f, 360.891f, 0.122173f}
};

class boss_ignis : public CreatureScript
{
    public:
        boss_ignis() : CreatureScript("boss_ignis") { }

        struct boss_ignis_AI : public BossAI
        {
            boss_ignis_AI(Creature* creature) : BossAI(creature, BOSS_IGNIS), _vehicle(me->GetVehicleKit())
            {
                assert(_vehicle);
            }

            void Reset()
            {
                _Reset();
                if (_vehicle)
                    _vehicle->RemoveAllPassengers();

                _creatureList.clear();

                for (uint8 i = 0; i < 20; ++i)
                    if (Creature* construct = me->SummonCreature(NPC_IRON_CONSTRUCT, Pos[i]))
                        _creatureList.push_back(construct);

                if (instance)
                    instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMED_START_EVENT);
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                DoScriptText(SAY_AGGRO, me);
                events.ScheduleEvent(EVENT_JET, 30000);
                events.ScheduleEvent(EVENT_SCORCH, 25000);
                events.ScheduleEvent(EVENT_SLAG_POT, 35000, 1);
                events.ScheduleEvent(EVENT_CONSTRUCT, 15000);
                events.ScheduleEvent(EVENT_BERSERK, 900000);
                _slagPotGUID = 0;
                _constructTimer = 0;
                _shattered = false;

                // Stokin' the Furnace
                if (instance)
                    instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMED_START_EVENT);
            }

            void JustDied(Unit* /*victim*/)
            {
                _JustDied();
                DoScriptText(SAY_DEATH, me);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                _DoAggroPulse(diff);
                events.Update(diff);
                _constructTimer += diff;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_JET:
                            me->MonsterTextEmote(EMOTE_JETS, 0, true);
                            DoCastAOE(SPELL_FLAME_JETS);
                            events.DelayEvents(5000, 1);
                            events.ScheduleEvent(EVENT_JET, urand(35000, 40000));
                            break;
                        case EVENT_SLAG_POT:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                            {
                                DoScriptText(SAY_SLAG_POT, me);
                                _slagPotGUID = target->GetGUID();
                                DoCast(target, SPELL_GRAB);
                                events.ScheduleEvent(EVENT_GRAB_POT, 500);
                            }
                            events.ScheduleEvent(EVENT_SLAG_POT, RAID_MODE(30000, 15000), 1);
                            break;
                        case EVENT_GRAB_POT:
                            if (Unit* slagPotTarget = Unit::GetUnit(*me, _slagPotGUID))
                            {
                                slagPotTarget->CastCustomSpell(SPELL_GRAB_ENTER_VEHICLE, SPELLVALUE_BASE_POINT0, 1, me, true);
                                events.ScheduleEvent(EVENT_CHANGE_POT, 1000);
                            }
                            break;
                        case EVENT_CHANGE_POT:
                            if (Unit* slagPotTarget = Unit::GetUnit(*me, _slagPotGUID))
                            {
                                me->AddAura(SPELL_SLAG_POT, slagPotTarget);
                                slagPotTarget->ExitVehicle();
                                slagPotTarget->CastCustomSpell(SPELL_GRAB_ENTER_VEHICLE, SPELLVALUE_BASE_POINT0, 2, me, true);
                                slagPotTarget->ClearUnitState(UNIT_STATE_ONVEHICLE); // Hack
                                _slagPotGUID = 0;
                            }
                            break;
                        case EVENT_SCORCH:
                            DoScriptText(RAND(SAY_SCORCH_1, SAY_SCORCH_2), me);
                            if (Unit* target = me->getVictim())
                                me->SummonCreature(NPC_GROUND_SCORCH, *target, TEMPSUMMON_TIMED_DESPAWN, 45000);
                            DoCast(SPELL_SCORCH);
                            events.ScheduleEvent(EVENT_SCORCH, 25000);
                            break;
                        case EVENT_CONSTRUCT:
                        {
                            DoScriptText(SAY_SUMMON, me);
                            if (!_creatureList.empty())
                            {
                                std::list<Creature*>::iterator itr = _creatureList.begin();
                                std::advance(itr, urand(0, _creatureList.size() - 1));
                                if (Creature* construct = (*itr))
                                {
                                    construct->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                                    construct->SetReactState(REACT_AGGRESSIVE);
                                    construct->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                                    construct->AI()->AttackStart(me->getVictim());
                                    construct->AI()->DoZoneInCombat();
                                    DoCast(me, SPELL_STRENGTH, true);
                                    _creatureList.erase(itr);
                                }
                            }
                            DoCast(SPELL_ACTIVATE_CONSTRUCT);
                            events.ScheduleEvent(EVENT_CONSTRUCT, RAID_MODE(40000, 30000));
                            break;
                        }
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK, true);
                            DoScriptText(SAY_BERSERK, me);
                            break;
                    }
                }

                DoMeleeAttackIfReady();

                EnterEvadeIfOutOfCombatArea(diff);
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (!(rand()%5))
                    DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
            }

            uint32 GetData(uint32 type)
            {
                if (type == DATA_SHATTERED)
                    return _shattered ? 1 : 0;

                return 0;
            }

            void DoAction(int32 const action)
            {
                switch (action)
                {
                    case ACTION_REMOVE_BUFF:
                        me->RemoveAuraFromStack(SPELL_STRENGTH);
                        // Shattered Achievement
                        if (_constructTimer >= 5000)
                            _constructTimer = 0;
                        else
                            _shattered = true;
                        break;
                }
            }

        private:
            Vehicle* _vehicle;
            std::list<Creature*> _creatureList;
            bool _shattered;
            uint64 _slagPotGUID;
            uint32 _constructTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_ignis_AI(creature);
        }
};

class npc_iron_construct : public CreatureScript
{
    public:
        npc_iron_construct() : CreatureScript("npc_iron_construct") { }

        struct npc_iron_constructAI : public ScriptedAI
        {
            npc_iron_constructAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = creature->GetInstanceScript();
                creature->setActive(true);
                creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                DoCast(me, SPELL_FREEZE_ANIM, true);
            }

            void Reset()
            {
                me->SetReactState(REACT_PASSIVE);
                _brittled = false;
            }

            void JustReachedHome()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                DoCast(me, SPELL_FREEZE_ANIM, true);
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage)
            {
                if (me->HasAura(RAID_MODE<uint32>(SPELL_BRITTLE, SPELL_BRITTLE_25)) && damage >= 5000)
                {
                    DoCast(me, SPELL_SHATTER, true);
                    if (Creature* ignis = me->GetCreature(*me, _instance->GetData64(BOSS_IGNIS)))
                        if (ignis->AI())
                            ignis->AI()->DoAction(ACTION_REMOVE_BUFF);

                    me->DespawnOrUnsummon(1000);
                }
            }

            void UpdateAI(uint32 const /*diff*/)
            {
                if (!UpdateVictim())
                    return;

                if (Aura* aur = me->GetAura(SPELL_HEAT))
                {
                    if (aur->GetStackAmount() >= 10)
                    {
                        me->RemoveAura(SPELL_HEAT);
                        DoCast(SPELL_MOLTEN);
                        _brittled = false;
                    }
                }

                // Water pools
                if (me->IsInWater() && !_brittled && me->HasAura(SPELL_MOLTEN))
                {
                    DoCast(SPELL_BRITTLE);
                    me->RemoveAura(SPELL_MOLTEN);
                    _brittled = true;
                }

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* _instance;
            bool _brittled;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_iron_constructAI(creature);
        }
};

class npc_scorch_ground : public CreatureScript
{
    public:
        npc_scorch_ground() : CreatureScript("npc_scorch_ground") { }

        struct npc_scorch_groundAI : public ScriptedAI
        {
            npc_scorch_groundAI(Creature* creature) : ScriptedAI(creature)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE |UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
                creature->SetDisplayId(16925);
            }

            void Reset()
            {
                DoCast(me, SPELL_GROUND);
            }

            void UpdateAI(uint32 const /*diff*/) { }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_scorch_groundAI(creature);
        }
};

class spell_ignis_slag_pot : public SpellScriptLoader
{
    public:
        spell_ignis_slag_pot() : SpellScriptLoader("spell_ignis_slag_pot") { }

        class spell_ignis_slag_pot_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ignis_slag_pot_AuraScript)

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SLAG_POT_DAMAGE))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SLAG_IMBUED))
                    return false;
                return true;
            }

            void HandleEffectPeriodic(AuraEffect const* aurEff)
            {
                Unit* aurEffCaster = aurEff->GetCaster();
                if (!aurEffCaster)
                    return;

                Unit* target = GetTarget();
                aurEffCaster->CastSpell(target, SPELL_SLAG_POT_DAMAGE, true);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->isAlive())
                    GetTarget()->CastSpell(GetTarget(), SPELL_SLAG_IMBUED, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_slag_pot_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
                AfterEffectRemove += AuraEffectRemoveFn(spell_ignis_slag_pot_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ignis_slag_pot_AuraScript();
        }
};

class spell_ignis_flame_jets : public SpellScriptLoader
{
    public:
        spell_ignis_flame_jets() : SpellScriptLoader("spell_ignis_flame_jets") { }

        class spell_ignis_flame_jets_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ignis_flame_jets_SpellScript);

            void FilterTargets(std::list<Unit*>& unitList)
            {
                unitList.remove_if(PlayerOrPetCheck());
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ignis_flame_jets_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ignis_flame_jets_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ignis_flame_jets_SpellScript::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ignis_flame_jets_SpellScript();
        }
};

class achievement_ignis_shattered : public AchievementCriteriaScript
{
    public:
        achievement_ignis_shattered() : AchievementCriteriaScript("achievement_ignis_shattered") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            if (target && target->IsAIEnabled)
                return target->GetAI()->GetData(DATA_SHATTERED);

            return false;
        }
};

void AddSC_boss_ignis()
{
    new boss_ignis();
    new npc_iron_construct();
    new npc_scorch_ground();
    new spell_ignis_slag_pot();
    new spell_ignis_flame_jets();
    new achievement_ignis_shattered();
}
