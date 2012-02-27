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

enum Spells
{
    SPELL_NECROTIC_AURA       = 55593,
    SPELL_SUMMON_SPORE        = 29234,
    SPELL_DEATHBLOOM          = 29865,
    H_SPELL_DEATHBLOOM        = 55053,
    SPELL_INEVITABLE_DOOM     = 29204,
    H_SPELL_INEVITABLE_DOOM   = 55052,
    SPELL_BERSERK             = 27680,
    SPELL_FUNGAL_CREEP        = 29232,
    SPELL_WARN_NECROTIC_AURA  = 59481
};

enum Events
{
    EVENT_AURA = 1,
    EVENT_BLOOM,
    EVENT_DOOM,
    EVENT_BERSERK
};

enum Texts
{
   SAY_NECROTIC_AURA_APPLIED       = 0,
   SAY_NECROTIC_AURA_REMOVED       = 1,
   SAY_NECROTIC_AURA_FADING        = 2,
};

enum Achievement
{
   DATA_ACHIEVEMENT_SPORE_LOSER    = 21822183,
};

class boss_loatheb : public CreatureScript
{
    public:
        boss_loatheb() : CreatureScript("boss_loatheb") { }

        struct boss_loathebAI : public BossAI
        {
            boss_loathebAI(Creature* c) : BossAI(c, BOSS_LOATHEB) {}

            void Reset()
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_AURA, 10000);
                events.ScheduleEvent(EVENT_BLOOM, 5000);
                events.ScheduleEvent(EVENT_DOOM, 120000);
                events.ScheduleEvent(EVENT_BERSERK, 12*60000);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                _DoAggroPulse(diff);
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_AURA:
                            DoCastAOE(SPELL_NECROTIC_AURA);
                            events.ScheduleEvent(EVENT_AURA, 20000);
                            break;
                        case EVENT_BLOOM:
                            // TODO : Add missing text
                            DoCastAOE(SPELL_SUMMON_SPORE, true);
                            DoCastAOE(RAID_MODE<uint32>(SPELL_DEATHBLOOM, H_SPELL_DEATHBLOOM));
                            events.ScheduleEvent(EVENT_BLOOM, 30000);
                            break;
                        case EVENT_DOOM:
                            DoCastAOE(RAID_MODE<uint32>(SPELL_INEVITABLE_DOOM, H_SPELL_INEVITABLE_DOOM));
                            events.ScheduleEvent(EVENT_DOOM, events.GetTimer() < 5*60000 ? 30000 : 15000);
                            break;
                        case EVENT_BERSERK:
                            if (Is25ManRaid() && !me->HasAura(SPELL_BERSERK))
                                DoCast(me, SPELL_BERSERK, true);
                            events.ScheduleEvent(EVENT_BERSERK, 60000);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_loathebAI(creature);
        }
};

class spell_fungal_creep_targeting : public SpellScriptLoader
{
    public:
        spell_fungal_creep_targeting() : SpellScriptLoader("spell_fungal_creep_targeting") { }

        class spell_fungal_creep_targeting_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_fungal_creep_targeting_SpellScript);

            void FilterTargetsInitial(std::list<Unit*>& unitList)
            {
                sharedUnitList = unitList;
            }

            void FilterTargetsSubsequent(std::list<Unit*>& unitList)
            {
                unitList = sharedUnitList;
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_fungal_creep_targeting_SpellScript::FilterTargetsInitial, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_fungal_creep_targeting_SpellScript::FilterTargetsSubsequent, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_fungal_creep_targeting_SpellScript::FilterTargetsSubsequent, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
            }

            std::list<Unit*> sharedUnitList;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_fungal_creep_targeting_SpellScript();
        }
};

class mob_loatheb_spore : public CreatureScript
{
    public:
        mob_loatheb_spore() : CreatureScript("mob_loatheb_spore") { }

        struct mob_loatheb_sporeAI : public ScriptedAI
        {
            mob_loatheb_sporeAI(Creature* c) : ScriptedAI(c) {}

            void DamageTaken(Unit* /*attacker*/, uint32 &damage)
            {
                if (damage >= me->GetHealth())
                    DoCastAOE(SPELL_FUNGAL_CREEP, true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_loatheb_sporeAI(creature);
        }
};

class achievement_spore_loser : public AchievementCriteriaScript
{
    public:
        achievement_spore_loser() : AchievementCriteriaScript("achievement_spore_loser") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            return target && target->GetAI()->GetData(DATA_ACHIEVEMENT_SPORE_LOSER);
        }
};

typedef boss_loatheb::boss_loathebAI LoathebAI;

class spell_loatheb_necrotic_aura_warning : public SpellScriptLoader
{
    public:
        spell_loatheb_necrotic_aura_warning() : SpellScriptLoader("spell_loatheb_necrotic_aura_warning") { }

        class spell_loatheb_necrotic_aura_warning_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_loatheb_necrotic_aura_warning_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellStore.LookupEntry(SPELL_WARN_NECROTIC_AURA))
                    return false;
                return true;
            }

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->IsAIEnabled)
                    CAST_AI(LoathebAI, GetTarget()->GetAI())->Talk(SAY_NECROTIC_AURA_APPLIED);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->IsAIEnabled)
                    CAST_AI(LoathebAI, GetTarget()->GetAI())->Talk(SAY_NECROTIC_AURA_REMOVED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_loatheb_necrotic_aura_warning_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_loatheb_necrotic_aura_warning_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_loatheb_necrotic_aura_warning_AuraScript();
        }
};

void AddSC_boss_loatheb()
{
    new boss_loatheb();
    new spell_fungal_creep_targeting();
    new mob_loatheb_spore();
    new achievement_spore_loser();
    new spell_loatheb_necrotic_aura_warning();
}
