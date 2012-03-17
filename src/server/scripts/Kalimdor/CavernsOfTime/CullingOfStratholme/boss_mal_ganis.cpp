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
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CARRION_SWARM                         = 52720,
    H_SPELL_CARRION_SWARM                       = 58852,
    SPELL_MIND_BLAST                            = 52722,
    H_SPELL_MIND_BLAST                          = 58850,
    SPELL_SLEEP                                 = 52721,
    H_SPELL_SLEEP                               = 58849,
    SPELL_VAMPIRIC_TOUCH                        = 52723,
    SPELL_KILL_CREDIT                           = 58630  // Serverside
};

enum Yells
{
    SAY_INTRO_1                                 = -1595009,
    SAY_INTRO_2                                 = -1595010,
    SAY_AGGRO                                   = -1595011,
    SAY_KILL_1                                  = -1595012,
    SAY_KILL_2                                  = -1595013,
    SAY_KILL_3                                  = -1595014,
    SAY_SLAY_1                                  = -1595015,
    SAY_SLAY_2                                  = -1595016,
    SAY_SLAY_3                                  = -1595017,
    SAY_SLAY_4                                  = -1595018,
    SAY_SLEEP_1                                 = -1595019,
    SAY_SLEEP_2                                 = -1595020,
    SAY_30HEALTH                                = -1595021,
    SAY_15HEALTH                                = -1595022,
    SAY_ESCAPE_SPEECH_1                         = -1595023,
    SAY_ESCAPE_SPEECH_2                         = -1595024,
    SAY_OUTRO                                   = -1595025,
};

enum CombatPhases
{
    COMBAT,
    OUTRO
};

class boss_mal_ganis : public CreatureScript
{
    public:
        boss_mal_ganis() : CreatureScript("boss_mal_ganis") { }

        struct boss_mal_ganisAI : public ScriptedAI
        {
            boss_mal_ganisAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                 _isBelow30PctHealth = false;
                 _isBelow15PctHealth = false;
                 _phase = COMBAT;
                 _carrionSwarmTimer = 6000;
                 _mindBlastTimer = 12500;
                 _vampiricTouchTimer = urand(10000, 15000);
                 _sleepTimer = urand(10000, 15000);
                 _outroTimer = 1000;

                 if (_instance)
                     _instance->SetData(DATA_MAL_GANIS_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoScriptText(SAY_AGGRO, me);
                if (_instance)
                    _instance->SetData(DATA_MAL_GANIS_EVENT, IN_PROGRESS);
            }

            void DamageTaken(Unit* /*attacker*/, uint32 &damage)
            {
                if (damage >= me->GetHealth())
                    damage = me->GetHealth() - 1;
            }

            void KilledUnit(Unit* /*victim*/)
            {
                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2, SAY_SLAY_3, SAY_SLAY_4), me);
            }

            void UpdateAI(uint32 const diff)
            {
                switch (_phase)
                {
                    case COMBAT:
                        if (!UpdateVictim())
                            return;

                        if (me->HasUnitState(UNIT_STATE_CASTING))
                            return;

                        if (!_isBelow30PctHealth && HealthBelowPct(30))
                        {
                            DoScriptText(SAY_30HEALTH, me);
                            _isBelow30PctHealth = true;
                        }

                        if (!_isBelow15PctHealth && HealthBelowPct(15))
                        {
                            DoScriptText(SAY_15HEALTH, me);
                            _isBelow15PctHealth = true;
                        }

                        if (HealthBelowPct(1))
                        {
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                            _outroStep = 1;
                            _phase = OUTRO;
                            return;
                        }

                        if (Creature* arthas = me->GetCreature(*me, _instance ? _instance->GetData64(DATA_ARTHAS) : 0))
                            if (arthas->isDead())
                            {
                                EnterEvadeMode();
                                me->DespawnOrUnsummon();
                                if (_instance)
                                    _instance->SetData(DATA_MAL_GANIS_EVENT, FAIL);
                            }

                        if (_carrionSwarmTimer <= diff)
                        {
                            DoCastVictim(DUNGEON_MODE(SPELL_CARRION_SWARM, H_SPELL_CARRION_SWARM));
                            _carrionSwarmTimer = 7000;
                        }
                        else
                            _carrionSwarmTimer -= diff;

                        if (_mindBlastTimer <= diff)
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                DoCast(target, DUNGEON_MODE(SPELL_MIND_BLAST, H_SPELL_MIND_BLAST));
                            _mindBlastTimer = 6000;
                        }
                        else
                            _mindBlastTimer -= diff;

                        if (_vampiricTouchTimer <= diff)
                        {
                            DoCast(me, SPELL_VAMPIRIC_TOUCH);
                            _vampiricTouchTimer = 20000;
                        }
                        else
                            _vampiricTouchTimer -= diff;

                        if (_sleepTimer <= diff)
                        {
                            DoScriptText(RAND(SAY_SLEEP_1, SAY_SLEEP_2), me);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                                DoCast(target, DUNGEON_MODE(SPELL_SLEEP, H_SPELL_SLEEP));
                            _sleepTimer = urand(12500, 17500);
                        }
                        else
                            _sleepTimer -= diff;

                        DoMeleeAttackIfReady();
                        break;
                    case OUTRO:
                        if (_outroTimer <= diff)
                        {
                            switch (_outroStep)
                            {
                                case 1:
                                    DoScriptText(SAY_ESCAPE_SPEECH_1, me);
                                    me->GetMotionMaster()->MoveTargetedHome();
                                    ++_outroStep;
                                    _outroTimer = 8000;
                                    break;
                                case 2:
                                    me->SetTarget(_instance ? _instance->GetData64(DATA_ARTHAS) : 0);
                                    me->HandleEmoteCommand(29);
                                    DoScriptText(SAY_ESCAPE_SPEECH_2, me);
                                    ++_outroStep;
                                    _outroTimer = 9000;
                                    break;
                                case 3:
                                    DoScriptText(SAY_OUTRO, me);
                                    ++_outroStep;
                                    _outroTimer = 16000;
                                    break;
                                case 4:
                                    me->HandleEmoteCommand(33);
                                    ++_outroStep;
                                    _outroTimer = 500;
                                    break;
                                case 5:
                                    me->DespawnOrUnsummon(1000);
                                    if (_instance)
                                    {
                                        _instance->SetData(DATA_MAL_GANIS_EVENT, DONE);
                                        // give achievement credit and LFG rewards to players.
                                        DoCast(me, SPELL_KILL_CREDIT, true);
                                        _instance->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, SPELL_KILL_CREDIT, NULL);
                                    }
                                    ++_outroStep;
                                    _outroTimer = 2000;
                                    break;
                            }
                        }
                        else
                            _outroTimer -= diff;
                        break;
                }
            }

        private:
            uint32 _carrionSwarmTimer;
            uint32 _mindBlastTimer;
            uint32 _vampiricTouchTimer;
            uint32 _sleepTimer;
            uint8 _outroStep;
            uint32 _outroTimer;
            bool _isBelow30PctHealth;
            bool _isBelow15PctHealth;
            CombatPhases _phase;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_mal_ganisAI(creature);
        }
};

void AddSC_boss_mal_ganis()
{
    new boss_mal_ganis();
}
