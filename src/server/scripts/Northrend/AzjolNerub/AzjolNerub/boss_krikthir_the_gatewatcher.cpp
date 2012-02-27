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
#include "azjol_nerub.h"

enum Spells
{
    // krikthir
    SPELL_MIND_FLAY                               = 52586,
    H_SPELL_MIND_FLAY                             = 59367,
    SPELL_CURSE_OF_FATIGUE                        = 52592,
    H_SPELL_CURSE_OF_FATIGUE                      = 59368,
    SPELL_FRENZY                                  = 28747,
    SPELL_SWARM                                   = 52440, // ( 52438,52439,52440,52448,52449,52450 )
    // skittering infector
    SPELL_ACID_SPLASH                             = 52446,
    H_SPELL_ACID_SPLASH                           = 59363,
    // anub'ar skirmisher
    SPELL_FIXATE                                  = 52537,
    SPELL_CHARGE                                  = 52538,
    SPELL_BACKSTAB                                = 52540,
    // anub'ar shadowcaster
    SPELL_SHADOW_BOLT                             = 52534,
    H_SPELL_SHADOW_BOLT                           = 59357,
    SPELL_SHADOW_NOVA                             = 52535,
    H_SPELL_SHADOW_NOVA                           = 59358,
    // anub'ar warrior
    SPELL_STRIKE                                  = 52532,
    SPELL_CLEAVE                                  = 49806,
    // common watcher spells
    SPELL_WEB_WRAP                                = 52086,
    SPELL_WEB_WRAP_STUN                           = 52087,
    SPELL_INFECTED_BITE                           = 52469,
    H_SPELL_INFECTED_BITE                         = 59364,
    // gashra
    SPELL_ENRAGE                                  = 52470,
    // narjil
    SPELL_BLINDING_WEBS                           = 52524,
    H_SPELL_BLINDING_WEBS                         = 59365,
    // silthik
    SPELL_POSION_SPRAY                            = 52493,
    H_SPELL_POSION_SPRAY                          = 59366
};

enum Creatures
{
    NPC_SKITTERING_SWARMER                        = 28735,
    NPC_SKITTERING_SWARMER_CONTROLLER             = 32593,
    NPC_SKITTERING_INFECTOR                       = 28736
};

enum Yells
{
    SAY_AGGRO                                     = -1601011,
    SAY_SLAY_1                                    = -1601012,
    SAY_SLAY_2                                    = -1601013,
    SAY_DEATH                                     = -1601014,
    SAY_SWARM_1                                   = -1601015,
    SAY_SWARM_2                                   = -1601016,
    SAY_PREFIGHT_1                                = -1601017,
    SAY_PREFIGHT_2                                = -1601018,
    SAY_PREFIGHT_3                                = -1601019,
    SAY_SEND_GROUP_1                              = -1601020,
    SAY_SEND_GROUP_2                              = -1601021,
    SAY_SEND_GROUP_3                              = -1601022
};

class boss_krik_thir : public CreatureScript
{
    public:
        boss_krik_thir() : CreatureScript("boss_krik_thir") { }

        struct boss_krik_thirAI : public ScriptedAI
        {
            boss_krik_thirAI(Creature* c) : ScriptedAI(c), _summons(me)
            {
                _instance = c->GetInstanceScript();
            }

            void Reset()
            {
                _frenzy = false;
           //     _summonTimer = 10*IN_MILLISECONDS;
                _mindFlayTimer = 12*IN_MILLISECONDS;
                _curseFatigueTimer = 7*IN_MILLISECONDS;

                _summons.DespawnAll();

                if (_instance)
                    _instance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoScriptText(SAY_AGGRO, me);

                if (_instance)
                    _instance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, IN_PROGRESS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

             /*   if (_summonTimer <= diff)
                {
                    DoScriptText(RAND(SAY_SWARM_1, SAY_SWARM_2), me);

                    DoCast(me, SPELL_SWARM);
                    _summonTimer = urand(20, 25) *IN_MILLISECONDS;
                }
                else
                    _summonTimer -= diff;*/

                if (_mindFlayTimer <= diff)
                {
                    DoCastVictim(SPELL_MIND_FLAY);
                    _mindFlayTimer = urand(10, 15) *IN_MILLISECONDS;
                }
                else
                    _mindFlayTimer -= diff;

                if (_curseFatigueTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(target, SPELL_CURSE_OF_FATIGUE);

                    _curseFatigueTimer = 20*IN_MILLISECONDS;
                }
                else
                    _curseFatigueTimer -= diff;

                if (!_frenzy && HealthBelowPct(20))
                {
                    me->InterruptNonMeleeSpells(true);
                    DoCast(me, SPELL_FRENZY, true);
                    _frenzy = true;
                }

                DoMeleeAttackIfReady();
            }

            void JustDied(Unit* /*killer*/)
            {
                DoScriptText(SAY_DEATH, me);

                if (_instance)
                    _instance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, DONE);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim == me)
                    return;

                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
            }

            void JustSummoned(Creature* summoned)
            {
               summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
               _summons.Summon(summoned);
            }

        private:
            InstanceScript* _instance;
            SummonList _summons;
            uint32 _mindFlayTimer;
            uint32 _curseFatigueTimer;
            uint32 _summonTimer;
            bool _frenzy;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_krik_thirAI(creature);
        }
};

class npc_skittering_infector : public CreatureScript
{
    public:
        npc_skittering_infector() : CreatureScript("npc_skittering_infector") { }

        struct npc_skittering_infectorAI : public ScriptedAI
        {
            npc_skittering_infectorAI(Creature* c) : ScriptedAI(c) {}

            void JustDied(Unit* /*killer*/)
            {
                DoCastAOE(DUNGEON_MODE<uint32>(SPELL_ACID_SPLASH, H_SPELL_ACID_SPLASH));
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_skittering_infectorAI(creature);
        }
};

class npc_anub_ar_skirmisher : public CreatureScript
{
    public:
        npc_anub_ar_skirmisher() : CreatureScript("npc_anub_ar_skirmisher") { }

        struct npc_anub_ar_skirmisherAI : public ScriptedAI
        {
            npc_anub_ar_skirmisherAI(Creature* c) : ScriptedAI(c) {}

            void Reset()
            {
                _chargeTimer = 10*IN_MILLISECONDS;
                _backstabTimer = 7*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (_chargeTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                    {
                        DoCast(target, SPELL_CHARGE, true);
                        target->CastSpell(me, SPELL_FIXATE, true);
                    }
                    _chargeTimer = 15*IN_MILLISECONDS;
                }
                else
                    _chargeTimer -= diff;

                if (_backstabTimer <= diff)
                {
                    if (me->getVictim()->isInBackInMap(me, 5.0f, 1.5f))
                        DoCastVictim(SPELL_BACKSTAB);
                    _backstabTimer = 5*IN_MILLISECONDS;
                }
                else
                    _backstabTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            uint32 _chargeTimer;
            uint32 _backstabTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_anub_ar_skirmisherAI(creature);
        }
};

class npc_anub_ar_shadowcaster : public CreatureScript
{
    public:
        npc_anub_ar_shadowcaster() : CreatureScript("npc_anub_ar_shadowcaster") { }

        struct npc_anub_ar_shadowcasterAI : public ScriptedAI
        {
            npc_anub_ar_shadowcasterAI(Creature* c) : ScriptedAI(c) {}

            void Reset()
            {
                _shadowBoltTimer = 6*IN_MILLISECONDS;
                _shadowNovaTimer = 12*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (_shadowBoltTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                         DoCast(target, SPELL_SHADOW_BOLT);
                    _shadowBoltTimer = 6*IN_MILLISECONDS;
                }
                else
                    _shadowBoltTimer -= diff;

                if (_shadowNovaTimer <= diff)
                {
                    DoCastVictim(SPELL_SHADOW_NOVA, true);
                    _shadowNovaTimer = 15*IN_MILLISECONDS;
                }
                else
                    _shadowNovaTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            uint32 _shadowBoltTimer;
            uint32 _shadowNovaTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_anub_ar_shadowcasterAI(creature);
        }
};

class npc_anub_ar_warrior : public CreatureScript
{
    public:
        npc_anub_ar_warrior() : CreatureScript("npc_anub_ar_warrior") { }

        struct npc_anub_ar_warriorAI : public ScriptedAI
        {
            npc_anub_ar_warriorAI(Creature* c) : ScriptedAI(c){}

            void Reset()
            {
                _cleaveTimer = 9*IN_MILLISECONDS;
                _strikeTimer = 6*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (_strikeTimer <= diff)
                {
                    DoCastVictim(SPELL_STRIKE, true);
                    _strikeTimer = 9*IN_MILLISECONDS;
                }
                else
                    _strikeTimer -= diff;

                if (_cleaveTimer <= diff)
                {
                    DoCastVictim(SPELL_CLEAVE, true);
                    _cleaveTimer = 12*IN_MILLISECONDS;
                }
                else
                    _cleaveTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            uint32 _cleaveTimer;
            uint32 _strikeTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_anub_ar_warriorAI(creature);
        }
};

class npc_krikthir_watcher : public CreatureScript
{
    public:
        npc_krikthir_watcher() : CreatureScript("npc_krikthir_watcher") { }

        struct npc_krikthir_watcherAI : public ScriptedAI
        {
            npc_krikthir_watcherAI(Creature* c) : ScriptedAI(c)
            {
                _instance = c->GetInstanceScript();
            }

            void Reset()
            {
                switch (me->GetEntry())
                {
                    // watcher narjil
                    case 28729:
                        _specialSpell = DUNGEON_MODE<uint32>(SPELL_BLINDING_WEBS, H_SPELL_BLINDING_WEBS);
                        break;
                    // watcher gashra
                    case 28730:
                        me->setFaction(14);
                        _specialSpell = SPELL_ENRAGE;
                        break;
                    // watcher silthik
                    case 28731:
                        _specialSpell = DUNGEON_MODE<uint32>(SPELL_POSION_SPRAY, H_SPELL_POSION_SPRAY);
                        break;
                    default:
                        _specialSpell = 0;
                        break;
                }

                _webWrapTimer      = 10*IN_MILLISECONDS;
                _infectedBiteTimer = 6*IN_MILLISECONDS;
                _specialSpellTimer = 15*IN_MILLISECONDS;
                _enwrapTimer       = 3*IN_MILLISECONDS;
                _wrapTarget        = 0;
                _enwrapping        = false;

                if (_instance)
                    _instance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                if (!_instance)
                    return;

                Creature* Krikthir = Unit::GetCreature(*me, _instance->GetData64(DATA_KRIKTHIR_THE_GATEWATCHER));
                if (Krikthir && Krikthir->isAlive())
                    DoScriptText(RAND(SAY_SEND_GROUP_1, SAY_SEND_GROUP_2, SAY_SEND_GROUP_3), Krikthir);

                _instance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, SPECIAL);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (_enwrapping)
                {
                    if (_enwrapTimer <= diff)
                    {
                        if (Unit* target = Unit::GetUnit(*me, _wrapTarget))
                        {
                            target->CastSpell(target, SPELL_WEB_WRAP_STUN, true);
                            _wrapTarget = NULL;
                        }
                        _enwrapping = false;
                        _enwrapTimer = 3*IN_MILLISECONDS;
                    }
                    else
                        _enwrapTimer -= diff;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (_webWrapTimer <= diff)
                {
                    Unit* target = NULL;
                    std::list<Unit *> playerList;
                    SelectTargetList(playerList, 5, SELECT_TARGET_RANDOM, 40, true);
                    for (std::list<Unit*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                    {
                        target = (*itr);
                        if (!target->HasAura(SPELL_WEB_WRAP) && !target->HasAura(SPELL_WEB_WRAP_STUN))
                            break;  // found someone

                        target = NULL;
                    }
                    // if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40, true, -SPELL_WEB_WRAP_STUN)
                    if (target)
                    {
                        _enwrapping = true;
                        _wrapTarget = target->GetGUID();
                        DoCast(target, SPELL_WEB_WRAP, false);
                    }
                    _webWrapTimer = 15*IN_MILLISECONDS;
                }
                else
                    _webWrapTimer -= diff;

                if (_infectedBiteTimer <= diff)
                {
                    DoCastVictim(SPELL_INFECTED_BITE, true);
                    _infectedBiteTimer = 15*IN_MILLISECONDS;
                }
                else
                    _infectedBiteTimer -= diff;

                if (_specialSpell)
                    if (_specialSpellTimer <= diff)
                    {
                        DoCast(_specialSpell);
                        _specialSpellTimer = 20*IN_MILLISECONDS;
                    }
                    else
                        _specialSpellTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* _instance;
            uint32 _webWrapTimer;
            uint32 _infectedBiteTimer;
            uint32 _specialSpell;
            uint32 _specialSpellTimer;
            uint32 _enwrapTimer;
            uint64 _wrapTarget;
            bool _enwrapping;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_krikthir_watcherAI(creature);
        }
};

class npc_web_wrap : public CreatureScript
{
    public:
        npc_web_wrap() : CreatureScript("npc_web_wrap") { }

        struct npc_web_wrapAI : public ScriptedAI
        {
            npc_web_wrapAI(Creature* c) : ScriptedAI(c) {}

            void Reset()
            {
                _wrapTargetGUID = 0;
            }

            void EnterCombat(Unit* /*who*/) {}
            void AttackStart(Unit* /*who*/) {}
            void MoveInLineOfSight(Unit* /*who*/) {}

            void JustDied(Unit* /*killer*/)
            {
                if (_wrapTargetGUID)
                {
                    Unit* target = Unit::GetUnit(*me, _wrapTargetGUID);
                    if (target)
                        target->RemoveAurasDueToSpell(SPELL_WEB_WRAP_STUN);
                }
                me->RemoveCorpse();
            }

            void UpdateAI(uint32 const /*diff*/)
            {
                if (!me->ToTempSummon())
                    return;

                // should not be here?
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    _wrapTargetGUID = summoner->GetGUID();

                Unit* temp = Unit::GetUnit((*me), _wrapTargetGUID);
                if ((temp && temp->isAlive() && !temp->HasAura(SPELL_WEB_WRAP_STUN)) || !temp)
                    me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }

        private:
            uint64 _wrapTargetGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_web_wrapAI(creature);
        }
};

class achievement_watch_him_die : public AchievementCriteriaScript
{
    public:
        achievement_watch_him_die() : AchievementCriteriaScript("achievement_watch_him_die")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            InstanceScript* instance = target->GetInstanceScript();
            if (!instance)
                return false;

            for (uint8 n = 0; n < 3; ++n)
            {
                Creature* watcher = ObjectAccessor::GetCreature(*target, instance->GetData64(DATA_WATCHER_GASHRA + n));
                if (!watcher || !watcher->isAlive())
                    return false;
            }

            return true;
        }
};

void AddSC_boss_krik_thir()
{
    new boss_krik_thir();
    new npc_krikthir_watcher();
    new npc_skittering_infector();
    new npc_anub_ar_warrior();
    new npc_anub_ar_skirmisher();
    new npc_anub_ar_shadowcaster();
    new npc_web_wrap();
    new achievement_watch_him_die();
}
