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
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603180,
    SAY_AGGRO_WITH_ELDER                        = -1603181,
    SAY_SLAY_1                                  = -1603182,
    SAY_SLAY_2                                  = -1603183,
    SAY_DEATH                                   = -1603184,
    SAY_BERSERK                                 = -1603185,
    SAY_SUMMON_CONSERVATOR                      = -1603186,
    SAY_SUMMON_TRIO                             = -1603187,
    SAY_SUMMON_LASHERS                          = -1603188,
    SAY_YS_HELP                                 = -1603189,

    // Elder Brightleaf
    SAY_BRIGHTLEAF_AGGRO                        = -1603190,
    SAY_BRIGHTLEAF_SLAY_1                       = -1603191,
    SAY_BRIGHTLEAF_SLAY_2                       = -1603192,
    SAY_BRIGHTLEAF_DEATH                        = -1603193,

    // Elder Ironbranch
    SAY_IRONBRANCH_AGGRO                        = -1603194,
    SAY_IRONBRANCH_SLAY_1                       = -1603195,
    SAY_IRONBRANCH_SLAY_2                       = -1603196,
    SAY_IRONBRANCH_DEATH                        = -1603197,

    // Elder Stonebark
    SAY_STONEBARK_AGGRO                         = -1603198,
    SAY_STONEBARK_SLAY_1                        = -1603199,
    SAY_STONEBARK_SLAY_2                        = -1603200,
    SAY_STONEBARK_DEATH                         = -1603201,
};

enum Events
{
    // Con-speed-atory timed achievement.
    // TODO Should be started when 1st trash is killed.
    ACHIEV_CON_SPEED_ATORY_START_EVENT          = 21597,
    SPELL_ACHIEVEMENT_CHECK                     = 65074,

    // Lumberjacked timed achievement.
    // TODO should be started when 1st elder is killed.
    // Spell should be casted when 3rd elder is killed.
    ACHIEV_LUMBERJACKED                         = 21686,
    SPELL_LUMBERJACKED_ACHIEVEMENT_CHECK        = 65296,
};

enum Achievements
{
    ACHIEVMENT_CON_SPEED_ATORY_10               = 2980,
    ACHIEVMENT_CON_SPEED_ATORY_25               = 2981,

    ACHIEVMENT_LUMBERJACKED_10                  = 2979,
    ACHIEVMENT_LUMBERJACKED_25                  = 3118,
};

enum Spells
{
    // Freya
    SPELL_BERSERK                               = 47008,
    SPELL_TOUCH_OF_EONAR_10                     = 62528,
    SPELL_TOUCH_OF_EONAR_25                     = 62892,
    SPELL_ATTUNED_TO_NATURE                     = 62519,
    SPELL_SUNBEAM_10                            = 62623,
    SPELL_SUNBEAM_25                            = 62872,

    SPELL_NATURE_BOMB_VISUAL                    = 64648, // Projectile Visual ... Dummy
    SPELL_NATURE_BOMB_SUMMON                    = 64606, // castet from player ...

    SPELL_SUMMON_WAVE_10                        = 62688, // Trigger 62687 in Spell Effekt
    SPELL_SUMMON_WAVE_10_SUMMON                 = 62687,
    SPELL_SUMMON_WAVE_3                         = 62686,
    SPELL_SUMMON_WAVE_1                         = 62685,

    SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_1    = 62572, // works
    SPELL_LIFEBINDERS_GIFT_SUMMON_1             = 62568,
    SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_2    = 62870, // works
    SPELL_LIFEBINDERS_GIFT_SUMMON_2             = 62869,
    SPELL_LIFEBINDERS_GIFT_VISUAL               = 62579,

    // Hardmode
    SPELL_STONEBARK_ESSENCE                     = 62483,
    SPELL_IRONBRANCH_ESSENCE                    = 62484,
    SPELL_BRIGHTLEAF_ESSENCE                    = 62485,

    SPELL_FREYA_UNSTABLE_ENERGY_10              = 62451,
    SPELL_FREYA_UNSTABLE_ENERGY_25              = 62865,
    SPELL_FREYA_IRON_ROOTS_10                   = 62283,
    SPELL_FREYA_IRON_ROOTS_25                   = 62930,
    SPELL_FREYA_GROUND_TREMOR_10                = 62437,
    SPELL_FREYA_GROUND_TREMOR_25                = 62859,

    //Nature Bomb
    SPELL_NATURE_BOMB_VISUAL_OBJECT             = 64600, // Gameobjectspawn 194902
    SPELL_NATURE_BOMB_EXPLOSION                 = 64587,
    SPELL_NATURE_BOMB_EXPLOSION_H               = 64650,

    // Freya Adds
    SPELL_ATTUNED_TO_NATURE_REMOVE_2            = 62524,
    SPELL_ATTUNED_TO_NATURE_REMOVE_10           = 62525,
    SPELL_ATTUNED_TO_NATURE_REMOVE_25           = 62521,

    // Eonar's Gift
    SPELL_LIFEBINDERS_GIFT_10                   = 62584,
    SPELL_LIFEBINDERS_GIFT_25                   = 64185,
    SPELL_PHEROMONES                            = 62619,
    SPELL_EONAR_VISUAL                          = 62579,

    // ???
    SUMMON_FREYA_CHEST                          = 62950, // 62952-62958

    //Adds
    //detonating lasher
    SPELL_DETONATE_10                           = 62598,
    SPELL_DETONATE_25                           = 62937,
    SPELL_FLAME_LASH                            = 62608,

    //ancient water spirit
    SPELL_TIDAL_WAVE_10                         = 62653,
    SPELL_TIDAL_WAVE_25                         = 62935,
    SPELL_WATER_REVIVE_VISUAL                   = 62849,

    //storm lasher
    SPELL_LIGHTNING_LASH_10                     = 62648,
    SPELL_LIGHTNING_LASH_25                     = 62939,
    SPELL_STORMBOLT_10                          = 62649,
    SPELL_STORMBOLT_25                          = 62938,
    SPELL_STORM_REVIVE_VISUAL                   = 62851,

    //snaplasher
    SPELL_HARDENED_BARK_10                      = 62664,
    SPELL_HARDENED_BARK_25                      = 64191,
    SPELL_LASHER_REVIVE_VISUAL                  = 62848,

    //ancient conservator
    SPELL_CONSERVATORS_GRIP                     = 62532,
    SPELL_NATURES_FURY_10                       = 62589,
    SPELL_NATURES_FURY_25                       = 63571,

    //healthy spore
    SPELL_HEALTHY_SPORE_VISUAL                  = 62538,
    SPELL_POTENT_PHEROMONES                     = 62541,
    SPELL_GROW                                  = 62559, //grow visual

    // Elder
    SPELL_DRAINED_OF_POWER                      = 62467, //while freya encounter in progress
    // Elder Brightleaf
    // all spells are triggered
    SPELL_SOLAR_FLARE_10                        = 62240, // Target Amount is affected by stackamount of Brightleaf flux
    SPELL_SOLAR_FLARE_25                        = 62920, // Target Amount is affected by stackamount of Brightleaf flux
    SPELL_UNSTABLE_ENERGY_10                    = 62217, // Remove Unstable Sun Beam Buff
    SPELL_UNSTABLE_ENERGY_25                    = 62922,
    SPELL_PHOTOSYNTHESIS                        = 62209, // While standing in Beam
    SPELL_BRIGHTLEAF_FLUX                       = 62262, // script effect needs to trigger 62239
    SPELL_BRIGHTLEAF_FLUX_BUFF                  = 62239, // randomstack 1-8
    SPELL_FLUX_PLUS                             = 62251, // randomspell with flux
    SPELL_FLUX_MINUS                            = 62252, // randomspell with flux
    SPELL_UNSTABLE_SUN_BEAM_SUMMON              = 62207, // 62921, 62221, 64088
    SPELL_UNSTABLE_SUN_BEAM_PERIODIC            = 62211, // Triggers the Beam, triggers 62243 and 62216
    SPELL_UNSTABLE_SUN_BEAM_TRIGGERD            = 62243,

    //Elder Ironbranch
    //only impale is not triggered
    SPELL_IMPALE_10                             = 62310,
    SPELL_IMPALE_25                             = 62928,
    SPELL_THORN_SWARM_10                        = 62285, // Need Target fix ?
    SPELL_THORN_SWARM_25                        = 62931,
    SPELL_IRON_ROOTS_10                         = 62438,
    SPELL_IRON_ROOTS_25                         = 62861,

    //Elder Stonebark
    //every spell is not triggered
    SPELL_FISTS_OF_STONE                        = 62344,
    SPELL_GROUND_TREMOR_10                      = 62325,
    SPELL_GROUND_TREMOR_25                      = 62932,
    SPELL_PETRIFIED_BARK_10                     = 62337,
    SPELL_PETRIFIED_BARK_25                     = 62933,
};

enum Entrys
{
    ENTRY_CREATURE_FREYA                        = 32906,
    ENTRY_CREATURE_ELDER_BRIGHTLEAF             = 32915,

    ENTRY_GAMEOBJECT_NATURE_BOMB                = 194902,

    ENTRY_CREATURE_SNAPLASHER                   = 32916,
    ENTRY_CREATURE_STORM_LASHER                 = 32919,
    ENTRY_CREATURE_DETONATING_LASHER            = 32918,
    ENTRY_CREATURE_ANCIENT_WATER_SPIRIT         = 33202,

    ENTRY_CREATURE_FREYA_ROOTS                  = 33088,

    ENTRY_CREATURE_UNSTABLE_SUN_BEAM            = 33050,
    ENTRY_CREATURE_EONARS_GIFT                  = 33228,
    ENTRY_CREATURE_SUNBEAM                      = 33170,
	 GO_FREYA_CHEST              = 194324,
    GO_FREYA_CHEST_HERO         = 194325,
    GO_FREYA_CHEST_HARD         = 194327,
    GO_FREYA_CHEST_HERO_HARD    = 194331,
};

enum Models
{
    MODEL_INVISIBLE                             = 11686,
};

enum Phase
{
    PHASE_SPAWNING,
    PHASE_NOT_SPAWNING
};

const uint32 WaveSpells[3] =
{
    SPELL_SUMMON_WAVE_10,
    SPELL_SUMMON_WAVE_3,
    SPELL_SUMMON_WAVE_1
};

enum Actions
{
    ACTION_ELEMENTAL_DEAD
};

enum Data
{
    DATA_GETTING_BACK_TO_NATURE,
    DATA_KNOCK_ON_WOOD
};

class boss_freya : public CreatureScript
{
public:
    boss_freya() : CreatureScript("boss_freya") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_freyaAI(creature);
    }

    struct boss_freyaAI : public ScriptedAI
    {
        boss_freyaAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
            if (pInstance)
                EncounterFinished = (pInstance->GetBossState(BOSS_FREYA) == DONE);
        }

        InstanceScript* pInstance;
        bool EncounterFinished;

        uint32 SpawnWaves[3];
        uint32 WaveCount;

        uint32 uiWave_Timer;
        uint32 Berserk_Timer;
        uint32 Lifebinders_Gift_Timer;
        uint32 uiSunbeam_Timer;
        uint32 Ground_Tremor_Timer;
        uint32 Iron_Roots_Timer;
        uint32 unstableEnergyTimer;
        uint32 uiNaturalBomb_Timer;
        uint32 inFightAggroCheck_Timer;
        uint32 attunedToNature;

        uint32 ReviveTimer;
        uint8 ReviveCount;
        std::set<uint64> elementalList;

        bool bIsElderBrightleafAlive;
        bool bIsElderIronbranchAlive;
        bool bIsElderStonebarkAlive;

        void Reset()
        {
            if (EncounterFinished)
            {
                me->setFaction(35);
            }
            else
            {
                if (pInstance)
                    pInstance->SetBossState(BOSS_FREYA, NOT_STARTED);

                ReviveCount = 0;
                ReviveTimer = 15000;
                elementalList.clear();

                WaveCount = 0;
                uiWave_Timer = 10000;
                Ground_Tremor_Timer = 30000;
                Iron_Roots_Timer = 22000;
                uiSunbeam_Timer = urand(20000, 30000);
                unstableEnergyTimer = 15000;
                Berserk_Timer = 600000;
                Lifebinders_Gift_Timer = 30000;
                uiNaturalBomb_Timer = 30000;
                inFightAggroCheck_Timer = 5000;
                attunedToNature = 0;

                bIsElderBrightleafAlive = bIsElderIronbranchAlive = bIsElderStonebarkAlive = false;

                Creature* Elder[3];
                for (uint8 n = 0; n < 3; ++n)
                {
                    Elder[n] = ObjectAccessor::GetCreature(*me, pInstance->GetData64(BOSS_BRIGHTLEAF + n));
                    if (Elder[n] && Elder[n]->isAlive())
                    {
                        //Elder[n]->RemoveAllAuras();
                        Elder[n]->ResetLootMode();
                        Elder[n]->AI()->EnterEvadeMode();
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void DamageTaken(Unit* /*attacker*/, uint32 &amount)
        {
            if (amount >= me->GetHealth())
            {
                amount = 0;
                EncounterIsDone();
            }
        }

        uint32 GetData(uint32 type)
        {
            switch (type)
            {
                case DATA_GETTING_BACK_TO_NATURE:
                    return attunedToNature;
                case DATA_KNOCK_ON_WOOD:
                    return GetElderCount();
            }

            return 0;
        }

        void DoAction(const int32 action)
        {
            switch (action)
            {
                case ACTION_ELEMENTAL_DEAD:
                    if (!ReviveCount)
                        ReviveTimer = 15000;
                    ++ReviveCount;
                    break;
                default:
                    break;
            }
        }

        void ReviveElementals()
        {
            if (ReviveCount >= elementalList.size())
                elementalList.clear();
            else
            {
                if (!elementalList.empty())
                    for (std::set<uint64>::const_iterator itr = elementalList.begin(); itr != elementalList.end(); ++itr)
                        if (Creature* temp = me->GetCreature(*me, *itr))
                        {
                            if (temp->isAlive())
                                temp->SetFullHealth();
                            else
                                temp->Respawn();

                            switch (temp->GetEntry())
                            {
                                case ENTRY_CREATURE_SNAPLASHER:
                                    temp->CastSpell(temp, SPELL_LASHER_REVIVE_VISUAL, true);
                                    break;
                                case ENTRY_CREATURE_STORM_LASHER:
                                    temp->CastSpell(temp, SPELL_STORM_REVIVE_VISUAL, true);
                                    break;
                                case ENTRY_CREATURE_ANCIENT_WATER_SPIRIT:
                                    temp->CastSpell(temp, SPELL_WATER_REVIVE_VISUAL, true);
                                    break;
                            }
                        }
            }

            ReviveCount = 0;
        }

        void JustSummoned(Creature* summon)
        {
            switch (summon->GetEntry())
            {
                case ENTRY_CREATURE_SNAPLASHER:
                case ENTRY_CREATURE_STORM_LASHER:
                case ENTRY_CREATURE_ANCIENT_WATER_SPIRIT:
                    elementalList.insert(summon->GetGUID());
                    break;
                default:
                    break;
            }
        }

        void InitSpawnWaves()
        {
             memset(&SpawnWaves, 0, sizeof(SpawnWaves));
             uint32 i_rand = urand(0, 2);
             switch (i_rand)
             {
                 case 0:
                     SpawnWaves[0] = i_rand;
                     if (urand(0, 1) == 0)
                     {
                         SpawnWaves[1] = 1;
                         SpawnWaves[2] = 2;
                     }else
                     {
                         SpawnWaves[1] = 2;
                         SpawnWaves[2] = 1;
                     }
                     break;
                 case 1:
                     SpawnWaves[0] = i_rand;
                     if (urand(0, 1) == 0)
                     {
                          SpawnWaves[1] = 0;
                          SpawnWaves[2] = 2;
                     }else
                     {
                          SpawnWaves[1] = 2;
                          SpawnWaves[2] = 0;
                     }
                     break;
                 case 2:
                     SpawnWaves[0] = i_rand;
                     if (urand(0, 1) == 0)
                     {
                          SpawnWaves[1] = 0;
                          SpawnWaves[2] = 1;
                     }else
                     {
                          SpawnWaves[1] = 1;
                          SpawnWaves[2] = 0;
                     }
                     break;
             }
        }

        void DoSummonWave()
        {
            uint32 spawntype = WaveCount % 3;
            DoCast(WaveSpells[SpawnWaves[spawntype]]);
            WaveCount++;
        }

        uint32 GetElderCount()
        {
            uint32 i = 0;
            if (bIsElderBrightleafAlive) i++;
            if (bIsElderIronbranchAlive) i++;
            if (bIsElderStonebarkAlive) i++;
            return i;
        }

        void EncounterIsDone()
        {
            if (EncounterFinished)
                return;

            EncounterFinished = true;
            DoScriptText(SAY_DEATH, me);

            if (!pInstance)
                return;

            pInstance->SetBossState(BOSS_FREYA, DONE);

            if (GetElderCount() == 3)
            {
                me->SummonGameObject(RAID_MODE(GO_FREYA_CHEST_HARD, GO_FREYA_CHEST_HERO_HARD), 2353.18f, -54.5f, 425.86f, 3.14159f, 0, 0, 0, 0, 604800);
            }
            else
            {
                if (GameObject* chest = me->SummonGameObject(RAID_MODE(GO_FREYA_CHEST, GO_FREYA_CHEST_HERO), 2353.18f, -54.5f, 425.86f, 3.14159f, 0, 0, 0, 0, 604800))
                {
                    switch (GetElderCount())
                    {
                        case 2:
                            chest->AddLootMode(4);
                        case 1:
                            chest->AddLootMode(2);
                            break;
                    }
                }
            }

            // getting back to nature achievement
            attunedToNature = me->GetAuraCount(SPELL_ATTUNED_TO_NATURE);

            EnterEvadeMode();
            me->DespawnOrUnsummon(7500);

            // achievements credit
            DoCast(me, SPELL_ACHIEVEMENT_CHECK, true);

            Creature* Elder[3];
            for (uint8 n = 0; n < 3; ++n)
            {
                Elder[n] = ObjectAccessor::GetCreature(*me, pInstance->GetData64(BOSS_BRIGHTLEAF + n));
                if (Elder[n] && Elder[n]->isAlive())
                    Elder[n]->DespawnOrUnsummon(2000);
            }
        }

        void JustReachedHome()
        {
            // TODO: use bossAI
            me->setActive(false);
        }

        void EnterCombat(Unit* who)
        {
            me->setActive(true);

            DoScriptText(SAY_AGGRO, me);

            // Add Attuned to Nature and Touch of Eonar
            DoCast(RAID_MODE(SPELL_TOUCH_OF_EONAR_10, SPELL_TOUCH_OF_EONAR_25));
            me->CastCustomSpell(SPELL_ATTUNED_TO_NATURE, SPELLVALUE_AURA_STACK, 150, me, true);

            if (pInstance)
            {
                InitSpawnWaves();
                pInstance->SetBossState(BOSS_FREYA, IN_PROGRESS);

                Creature* Elder[3];
                for (uint8 n = 0; n < 3; ++n)
                {
                    Elder[n] = ObjectAccessor::GetCreature(*me, pInstance->GetData64(BOSS_BRIGHTLEAF + n));
                    if (Elder[n] && Elder[n]->isAlive())
                    {
                        me->AddAura(SPELL_DRAINED_OF_POWER, Elder[n]);
                        Elder[n]->RemoveLootMode(LOOT_MODE_DEFAULT);
                        Elder[n]->AI()->AttackStart(who);
                        Elder[n]->AddThreat(who, 250.0f);
                        Elder[n]->SetInCombatWith(who);
                    }
                }

                if (Elder[0]->isAlive())
                {
                    Elder[0]->CastSpell(me, SPELL_BRIGHTLEAF_ESSENCE, true);
                    bIsElderBrightleafAlive = true;
                }

                if (Elder[1]->isAlive())
                {
                    Elder[1]->CastSpell(me, SPELL_IRONBRANCH_ESSENCE, true);
                    bIsElderIronbranchAlive = true;
                }

                if (Elder[2]->isAlive())
                {
                    Elder[2]->CastSpell(me, SPELL_STONEBARK_ESSENCE, true);
                    bIsElderStonebarkAlive = true;
                }
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (inFightAggroCheck_Timer < diff)
            {
                if (me->getVictim() && me->getVictim()->ToPlayer())
                    DoAttackerGroupInCombat(me->getVictim()->ToPlayer());
                inFightAggroCheck_Timer = 5000;
            } else inFightAggroCheck_Timer -= diff;

            if (ReviveCount)
            {
                if (ReviveTimer < diff)
                    ReviveElementals();
                else ReviveTimer -= diff;
            }

            if (WaveCount < 6)
                if (uiWave_Timer < diff)
                {
                    if (!me->IsNonMeleeSpellCasted(false))
                    {
                        DoSummonWave();
                        uiWave_Timer = 60000;
                    }
                } else uiWave_Timer -= diff;
            else
            {
                if (uiNaturalBomb_Timer <= diff)
                {
                    std::list<Player*> plrList = me->GetNearestPlayersList(500);
                    Trinity::Containers::RandomResizeList<Player*>(plrList, uint32(Is25ManRaid() ? urand(10, 15) : urand(4, 6)));
                    for (std::list<Player*>::const_iterator itr = plrList.begin(); itr != plrList.end(); ++itr)
                        if (*itr)
                            me->CastSpell((*itr), SPELL_NATURE_BOMB_VISUAL, true);

                    uiNaturalBomb_Timer = urand(20000, 30000);
                }
                else
                    uiNaturalBomb_Timer -= diff;
            }

            if (Berserk_Timer <= diff)
            {
                if (!me->HasAura(SPELL_BERSERK))
                    DoCast(me, SPELL_BERSERK, true);
            } else Berserk_Timer -= diff;

            // Hardmode Elder Stonebark
            if (bIsElderStonebarkAlive)
            {
                if (Ground_Tremor_Timer <= diff)
                {
                    if (!me->IsNonMeleeSpellCasted(false))
                    {
                        DoCast(RAID_MODE<uint32>(SPELL_FREYA_GROUND_TREMOR_10, SPELL_FREYA_GROUND_TREMOR_25));
                        Ground_Tremor_Timer = 30000;
                    }
                    else Ground_Tremor_Timer = 3000;
                }
                else Ground_Tremor_Timer -= diff;	
            }

            // Hardmode Elder Ironbranch
            if (bIsElderIronbranchAlive)
            {
                if (Iron_Roots_Timer <= diff)
                {
                    if (!me->IsNonMeleeSpellCasted(false))
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 500, true))
                            target->CastSpell(target, RAID_MODE<uint32>(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25), false);
                        Iron_Roots_Timer = urand(25000, 30000);
                    }
                    else Iron_Roots_Timer = 3000;
                }
                else Iron_Roots_Timer -= diff;
            }

            // Hardmode Elder Brightleaf
            if (bIsElderBrightleafAlive)
            {
                if (unstableEnergyTimer <= diff)
                {
                    std::list<Unit*> targets;
                    SelectTargetList(targets, RAID_MODE<uint32>(1, 3), SELECT_TARGET_RANDOM, 150.0f, true);
                    if (!targets.empty())
                        for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                            me->SummonCreature(ENTRY_CREATURE_SUNBEAM, (*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ());

                    unstableEnergyTimer = urand(25000, 30000);
                }
                else
                    unstableEnergyTimer -= diff;
            }

            if (Lifebinders_Gift_Timer <= diff)
            {
                DoCastAOE(RAID_MODE<uint32>(SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_1, SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_2), true);
                Lifebinders_Gift_Timer = 35000 + urand(2000, 10000);
            } else Lifebinders_Gift_Timer -= diff;

            if (uiSunbeam_Timer <= diff)
            {
                if (!me->IsNonMeleeSpellCasted(false))
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 500, true))
                        DoCast(target, RAID_MODE<uint32>(SPELL_SUNBEAM_10, SPELL_SUNBEAM_25));
                    else
                        DoCastVictim(RAID_MODE<uint32>(SPELL_SUNBEAM_10, SPELL_SUNBEAM_25));
                    uiSunbeam_Timer = urand(20000, 30000);
                }
                else uiSunbeam_Timer = 3000;
            } else uiSunbeam_Timer -= diff;

            DoMeleeAttackIfReady();

            //EnterEvadeIfOutOfCombatArea(diff);
        }
    };
};


class mob_natural_bomb : public CreatureScript
{
public:
    mob_natural_bomb() : CreatureScript("mob_natural_bomb") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_natural_bombAI(creature);
    }

    struct mob_natural_bombAI : public Scripted_NoMovementAI
    {
        mob_natural_bombAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(23258);
            me->setFaction(14);
        }

        uint32 uiExplosion_Timer;

        void Reset()
        {
            DoCast(SPELL_NATURE_BOMB_VISUAL_OBJECT);
            uiExplosion_Timer = 10000;
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiExplosion_Timer < diff)
            {
                if (GameObject* go_bomb = me->FindNearestGameObject(ENTRY_GAMEOBJECT_NATURE_BOMB, 1.0f))
                    go_bomb->SetGoState(GO_STATE_ACTIVE);

                DoCast(RAID_MODE(SPELL_NATURE_BOMB_EXPLOSION, SPELL_NATURE_BOMB_EXPLOSION_H));
                me->DespawnOrUnsummon(2000);
                uiExplosion_Timer = 10000;
            }else uiExplosion_Timer -= diff;
        }
    };
};

class spell_freya_natural_bomb_spell : public SpellScriptLoader
{
public:
    spell_freya_natural_bomb_spell() : SpellScriptLoader("spell_freya_natural_bomb_spell") { }

    class spell_freya_natural_bomb_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_freya_natural_bomb_SpellScript);

        void OnHitEffect()
        {
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, SPELL_NATURE_BOMB_SUMMON, true);
        }

        void Register()
        {
            OnHit += SpellHitFn(spell_freya_natural_bomb_SpellScript::OnHitEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_freya_natural_bomb_SpellScript();
    }
};

class spell_attuned_to_nature_remove_spell : public SpellScriptLoader
{
public:
    spell_attuned_to_nature_remove_spell() : SpellScriptLoader("spell_attuned_to_nature_remove") { }

    class spell_attuned_to_nature_remove_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_attuned_to_nature_remove_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return;

            if (Unit* unitTarget = GetHitUnit())
            {
                uint8 count = 0;
                switch (GetSpellInfo()->Id)
                {
                    case SPELL_ATTUNED_TO_NATURE_REMOVE_2 : count = 2; break;
                    case SPELL_ATTUNED_TO_NATURE_REMOVE_10 : count = 10; break;
                    case SPELL_ATTUNED_TO_NATURE_REMOVE_25 : count = 25; break;
                }
                if (Aura* aur = unitTarget->GetAura(SPELL_ATTUNED_TO_NATURE, unitTarget->GetGUID()))
                    aur->ModStackAmount(-count);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_attuned_to_nature_remove_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_attuned_to_nature_remove_SpellScript();
    }
};

class spell_summon_wave_effect_10mob_spell : public SpellScriptLoader
{
public:
    spell_summon_wave_effect_10mob_spell() : SpellScriptLoader("spell_summon_wave_effect_10mob") { }

    class spell_summon_wave_effect_10mob_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_summon_wave_effect_10mob_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return;

            for (uint8 i = 0; i < 10; i++)
                GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_WAVE_10_SUMMON, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_summon_wave_effect_10mob_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_summon_wave_effect_10mob_SpellScript();
    }
};

class mob_detonating_lasher : public CreatureScript
{
public:
    mob_detonating_lasher() : CreatureScript("mob_detonating_lasher") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_detonating_lasherAI(creature);
    }

    struct mob_detonating_lasherAI : public ScriptedAI
    {
        mob_detonating_lasherAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        uint32 Flame_Lash_Timer;
        uint32 changeTargetTimer;

        void Reset()
        {
            if (Unit* target = me->SelectNearbyTarget(me,100))
                AttackStart(target);

            Flame_Lash_Timer = urand(2000, 5000);
            changeTargetTimer = 7500;
        }

        void DamageTaken(Unit* /*attacker*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                if (Creature* freya = me->GetCreature(*me, m_pInstance->GetData64(BOSS_FREYA)))
                    DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_2, true);

                me->DespawnOrUnsummon(15000);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoCast(me, RAID_MODE(SPELL_DETONATE_10, SPELL_DETONATE_25), true);
        }

        void UpdateAI(const uint32 diff)
        {
            if (m_pInstance && m_pInstance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                me->DespawnOrUnsummon(2000);

            if (!UpdateVictim())
                return;

            if (Flame_Lash_Timer <= diff)
            {
                DoCastVictim(SPELL_FLAME_LASH);
                Flame_Lash_Timer = urand(3000, 6000);
            }
            else Flame_Lash_Timer -= diff;

            if (changeTargetTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                {
                    DoResetThreat();
                    me->AddThreat(target, 999999.9f);
                }
                changeTargetTimer = urand(5000, 10000);
            }
            else changeTargetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_ancient_water_spirit : public CreatureScript
{
public:
    mob_ancient_water_spirit() : CreatureScript("mob_ancient_water_spirit") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_ancient_water_spiritAI(creature);
    }

    struct mob_ancient_water_spiritAI : public ScriptedAI
    {
        mob_ancient_water_spiritAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
            alreadyKilled = false;
        }

        InstanceScript* m_pInstance;
        uint32 Tidal_Wave_Timer;
        bool alreadyKilled;

        void Reset()
        {
            me->SetCorpseDelay(20);
            Tidal_Wave_Timer = 20000;

            if (Unit* target = me->SelectNearbyTarget(me,100))
                me->AI()->AttackStart(target);
        }

        void DamageTaken(Unit* /*attacker*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                if (Creature* freya = me->GetCreature(*me, m_pInstance->GetData64(BOSS_FREYA)))
                {
                    if (!alreadyKilled)
                        DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10, true);

                    alreadyKilled = true;
                    freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
                }
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (m_pInstance && m_pInstance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                me->DespawnOrUnsummon(2000);

            if (!UpdateVictim())
                return;

            if (Tidal_Wave_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_TIDAL_WAVE_10, SPELL_TIDAL_WAVE_25));
                Tidal_Wave_Timer = 20000;
            }
            else {Tidal_Wave_Timer -= diff;}

            DoMeleeAttackIfReady();
        }

    };
};

class mob_storm_lasher : public CreatureScript
{
public:
    mob_storm_lasher() : CreatureScript("mob_storm_lasher") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_storm_lasherAI(creature);
    }

    struct mob_storm_lasherAI : public ScriptedAI
    {
        mob_storm_lasherAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
            alreadyKilled = false;
        }

        InstanceScript* m_pInstance;
        uint32 Lightning_Lash_Timer;
        uint32 Stormbolt_Timer;
        bool alreadyKilled;

        void Reset()
        {
            me->SetCorpseDelay(20);
            Lightning_Lash_Timer = 6000;
            Stormbolt_Timer = 3000;

            if (Unit* target = me->SelectNearbyTarget(me,100))
                me->AI()->AttackStart(target);
        }

        void DamageTaken(Unit* /*attacker*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                if (Creature* freya = me->GetCreature(*me, m_pInstance->GetData64(BOSS_FREYA)))
                {
                    if (!alreadyKilled)
                        DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10, true);
                    alreadyKilled = true;
                    freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
                }
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (m_pInstance && m_pInstance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                me->DespawnOrUnsummon(2000);

            if (!UpdateVictim())
                return;

            if (Lightning_Lash_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_LIGHTNING_LASH_10, SPELL_LIGHTNING_LASH_25));
                Lightning_Lash_Timer = 6000;
            }
            else Lightning_Lash_Timer -= diff;

            if (Stormbolt_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_STORMBOLT_10, SPELL_STORMBOLT_25));
                Stormbolt_Timer = 3000;
            }
            else Stormbolt_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_snaplasher : public CreatureScript
{
public:
    mob_snaplasher() : CreatureScript("mob_snaplasher") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_snaplasherAI(creature);
    }

    struct mob_snaplasherAI : public ScriptedAI
    {
        mob_snaplasherAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
            alreadyKilled = false;
        }

        InstanceScript* m_pInstance;
        bool alreadyKilled;

        void Reset()
        {
            me->SetCorpseDelay(20);
            if (Unit* target = me->SelectNearbyTarget(me,100))
                me->AI()->AttackStart(target);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoCast(me, RAID_MODE(SPELL_HARDENED_BARK_10, SPELL_HARDENED_BARK_25));
        }

        void DamageTaken(Unit* /*attacker*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                if (Creature* freya = me->GetCreature(*me, m_pInstance->GetData64(BOSS_FREYA)))
                {
                    if (!alreadyKilled)
                        DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10, true);
                    alreadyKilled = true;
                    freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
                }
            }
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            if (m_pInstance && m_pInstance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                me->DespawnOrUnsummon(2000);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_ancient_conservator : public CreatureScript
{
    public:
        mob_ancient_conservator() : CreatureScript("mob_ancient_conservator") { }

        struct mob_ancient_conservatorAI : public ScriptedAI
        {
            mob_ancient_conservatorAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                _naturesFuryTimer = 10000;
                _healthySporeSpawnTimer = urand(15000, 23000);

                if (Unit* target = me->SelectNearbyTarget(me,100.0f))
                    AttackStart(target);
            }

            void EnterCombat(Unit* /*who*/)
            {
                // TODO: fix this one, might somehow cause client errors?
                DoCast(SPELL_CONSERVATORS_GRIP);

                for (uint8 i = 1; i <= 6; ++i)
                {
                    Position pos;
                    me->GetRandomNearPosition(pos, 35.0f);
                    me->SummonCreature(33215, pos, TEMPSUMMON_TIMED_DESPAWN, urand(30000, 36000));
                }
            }

            void DamageTaken(Unit* /*attacker*/, uint32 &damage)
            {
                if (damage >= me->GetHealth())
                {
                    if (Creature* freya = me->GetCreature(*me, _instance->GetData64(BOSS_FREYA)))
                        DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_25, true);

                    me->DespawnOrUnsummon(15000);
                }
            }

            void UpdateAI(uint32 const diff)
            {
                if (_instance && _instance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                    me->DespawnOrUnsummon(2000);

                if (!UpdateVictim())
                    return;

                if (_naturesFuryTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(target, RAID_MODE<uint32>(SPELL_NATURES_FURY_10, SPELL_NATURES_FURY_25));
                    _naturesFuryTimer = 15000;
                }
                else
                    _naturesFuryTimer -= diff;

                if (_healthySporeSpawnTimer <= diff)
                {
                    Position pos;
                    me->GetRandomNearPosition(pos, 35.0f);
                    me->SummonCreature(33215, pos, TEMPSUMMON_TIMED_DESPAWN, 30000);
                    _healthySporeSpawnTimer = urand(2500, 5000);
                }
                else
                    _healthySporeSpawnTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* _instance;
            uint32 _naturesFuryTimer;
            uint32 _healthySporeSpawnTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_ancient_conservatorAI(creature);
        }
};

class mob_healthy_spore : public CreatureScript
{
    public:
        mob_healthy_spore() : CreatureScript("mob_healthy_spore") { }

        struct mob_healthy_sporeAI : public Scripted_NoMovementAI
        {
            mob_healthy_sporeAI(Creature* creature) : Scripted_NoMovementAI(creature)
            {
                _instance = creature->GetInstanceScript();
                _shrinkTimer = urand(22000, 30000);
            }

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                me->setFaction(35);
                DoCast(me, SPELL_HEALTHY_SPORE_VISUAL, true);
                DoCast(me, SPELL_GROW, true);
                DoCast(me, SPELL_POTENT_PHEROMONES, true);
            }

            void UpdateAI(uint32 const diff)
            {
                if (_instance && _instance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                    me->DisappearAndDie();

                if (_shrinkTimer <= diff)
                {
                    me->RemoveAurasDueToSpell(SPELL_GROW);
                    me->DespawnOrUnsummon(2000);
                    _shrinkTimer = 3000;
                }
                else
                    _shrinkTimer -= diff;
            }

        private:
            InstanceScript* _instance;
            uint32 _shrinkTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_healthy_sporeAI(creature);
        }
};


class mob_elder_brightleaf : public CreatureScript
{
public:
    mob_elder_brightleaf() : CreatureScript("mob_elder_brightleaf") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_elder_brightleafAI(creature);
    }

    struct mob_elder_brightleafAI : public ScriptedAI
    {
        mob_elder_brightleafAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Solar_Flare_Timer;
        uint32 Flux_Timer;
        uint32 Unstable_Sunbeam_Timer;

        void Reset()
        {
            Solar_Flare_Timer = 10000;
            Flux_Timer = 1000;
            Unstable_Sunbeam_Timer = 5000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (!me->HasAura(SPELL_DRAINED_OF_POWER))
                DoScriptText(SAY_BRIGHTLEAF_AGGRO, me);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_BRIGHTLEAF_SLAY_1, SAY_BRIGHTLEAF_SLAY_2), me);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_IRONBRANCH_AGGRO, me);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim() || me->HasAura(SPELL_DRAINED_OF_POWER))
                return;

            if (Solar_Flare_Timer <= diff)
            {
                uint32 target_count = me->GetAuraCount(SPELL_BRIGHTLEAF_FLUX_BUFF);
                me->CastCustomSpell(RAID_MODE(SPELL_SOLAR_FLARE_10, SPELL_SOLAR_FLARE_25),SPELLVALUE_MAX_TARGETS, target_count, me, true);
                //DoCastAOE(RAID_MODE(SPELL_SOLAR_FLARE_10, SPELL_SOLAR_FLARE_25),true);
                Solar_Flare_Timer = 10000 + urand(1500, 6000);
            }
            else { Solar_Flare_Timer -= diff; }

            if (Unstable_Sunbeam_Timer <= diff)
            {
                DoCast(me, SPELL_UNSTABLE_SUN_BEAM_SUMMON, true);
                Unstable_Sunbeam_Timer = 30000;
            }
            else Unstable_Sunbeam_Timer -= diff;

            // Workaround for Spellscript
            if (Flux_Timer <= diff)
            {
                me->RemoveAurasDueToSpell(SPELL_FLUX_PLUS);
                me->RemoveAurasDueToSpell(SPELL_FLUX_MINUS);

                me->CastSpell(me, SPELL_BRIGHTLEAF_FLUX, true);
                if (!me->HasAura(SPELL_BRIGHTLEAF_FLUX_BUFF))
                    me->CastSpell(me, SPELL_BRIGHTLEAF_FLUX_BUFF, true);
                me->SetAuraStack(SPELL_BRIGHTLEAF_FLUX_BUFF, me, urand(1, 10));
                uint8 flux = rand() %2;
                if (flux == 1)
                    me->AddAura(SPELL_FLUX_PLUS, me);
                else
                    me->AddAura(SPELL_FLUX_MINUS, me);
                Flux_Timer = 5000;
            }else Flux_Timer -= diff;

            DoMeleeAttackIfReady();
        }

    };
};

// Need more work
class mob_unstable_sunbeam : public CreatureScript
{
public:
    mob_unstable_sunbeam() : CreatureScript("mob_unstable_sunbeam") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_unstable_sunbeamAI(creature);
    }

    struct mob_unstable_sunbeamAI : public Scripted_NoMovementAI
    {
        mob_unstable_sunbeamAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

        uint32 Unstable_Energy_Timer;

        void Reset()
        {
            me->CastSpell(me, SPELL_UNSTABLE_SUN_BEAM_PERIODIC, true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE );
            me->SetDisplayId(MODEL_INVISIBLE);

            Unstable_Energy_Timer = urand(30000, 45000);
        }

        void MoveInLineOfSight(Unit* mover)
        {
            //Dont know if correct
            //if(mover && mover->ToPlayer())
            //    if(!me->IsWithinDist2d(mover,4))
            //    {
            //        if(mover->HasAura(SPELL_UNSTABLE_SUN_BEAM_TRIGGERD))
            //            mover->RemoveAurasDueToSpell(SPELL_UNSTABLE_SUN_BEAM_TRIGGERD);
            //    }

            if (mover && mover->ToCreature() && mover->GetEntry() == 32915)
                if (me->IsWithinDist2d(mover, 4))
                {
                    if (!mover->HasAura(SPELL_PHOTOSYNTHESIS))
                        me->AddAura(SPELL_PHOTOSYNTHESIS, mover);
                }else
                {
                    if (mover->HasAura(SPELL_PHOTOSYNTHESIS))
                        mover->RemoveAurasDueToSpell(SPELL_PHOTOSYNTHESIS);
                }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            switch (spell->Id)
            {
                case SPELL_UNSTABLE_ENERGY_10:
                case SPELL_UNSTABLE_ENERGY_25:
                    target->RemoveAurasDueToSpell(SPELL_UNSTABLE_SUN_BEAM_TRIGGERD);
                    break;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (Unstable_Energy_Timer <= diff)
            {
                DoCast(me, RAID_MODE(SPELL_UNSTABLE_ENERGY_10, SPELL_UNSTABLE_ENERGY_25), true);
                me->DespawnOrUnsummon(2000);
                Unstable_Energy_Timer = urand(30000, 45000);
            }
            else {Unstable_Energy_Timer -= diff;}
        }
    };
};


class mob_elder_ironbranch : public CreatureScript
{
public:
   mob_elder_ironbranch() : CreatureScript("mob_elder_ironbranch") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_elder_ironbranchAI(creature);
    }

    struct mob_elder_ironbranchAI : public ScriptedAI
    {
        mob_elder_ironbranchAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Impale_Timer;
        uint32 Iron_Roots_Timer;
        uint32 Thorn_Swarm_Timer;

        void EnterCombat(Unit* /*who*/)
        {
            if (!me->HasAura(SPELL_DRAINED_OF_POWER))
                DoScriptText(SAY_IRONBRANCH_AGGRO, me);
        }

        void Reset()
        {
            Impale_Timer = 45000;
            Iron_Roots_Timer = 15000;
            Thorn_Swarm_Timer = 2000;
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_IRONBRANCH_SLAY_1, SAY_IRONBRANCH_SLAY_2), me);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_IRONBRANCH_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim() || me->HasAura(SPELL_DRAINED_OF_POWER))
                return;

            if (Impale_Timer <= diff)
            {
                DoScriptText(SAY_IRONBRANCH_DEATH, me);
                DoCastVictim(RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25));
                Impale_Timer = 20000;
            }
            else Impale_Timer -= diff;

            if (Iron_Roots_Timer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                    target->CastSpell(target, RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25), true);
                Iron_Roots_Timer = urand(20000, 30000);
            }
            else Iron_Roots_Timer -= diff;

            if (Thorn_Swarm_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_THORN_SWARM_10, SPELL_THORN_SWARM_25));
                Thorn_Swarm_Timer = 20000;
            }
            else Thorn_Swarm_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};


class mob_elder_stonebark : public CreatureScript
{
public:
   mob_elder_stonebark() : CreatureScript("mob_elder_stonebark") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_elder_stonebarkAI(creature);
    }

    struct mob_elder_stonebarkAI : public ScriptedAI
    {
        mob_elder_stonebarkAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Fists_Of_Stone_Timer;
        uint32 Ground_Tremor_Timer;
        uint32 Petrified_Bark_Timer;

        void EnterCombat(Unit* /*who*/)
        {
            if (!me->HasAura(SPELL_DRAINED_OF_POWER))
                DoScriptText(SAY_STONEBARK_AGGRO, me);
        }

        void Reset()
        {
            Fists_Of_Stone_Timer = 25000;
            Ground_Tremor_Timer = 12000;
            Petrified_Bark_Timer = 17000;
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_STONEBARK_SLAY_1, SAY_STONEBARK_SLAY_2), me);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_STONEBARK_DEATH, me);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim() || me->HasAura(SPELL_DRAINED_OF_POWER))
                return;

            if (Fists_Of_Stone_Timer <= diff)
            {
                DoCast(SPELL_FISTS_OF_STONE);
                Fists_Of_Stone_Timer = 45000;
            }
            else Fists_Of_Stone_Timer -= diff;

            if (Ground_Tremor_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_GROUND_TREMOR_10, SPELL_GROUND_TREMOR_25));
                Ground_Tremor_Timer = 200000 + urand(3000, 10000);
            }
            else Ground_Tremor_Timer -= diff;

            if (Petrified_Bark_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_PETRIFIED_BARK_10, SPELL_PETRIFIED_BARK_25));
                Petrified_Bark_Timer = 40000;
            }
            else Petrified_Bark_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_eonars_gift : public CreatureScript
{
public:
   mob_eonars_gift() : CreatureScript("mob_eonars_gift") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_eonars_giftAI(creature);
    }

    struct mob_eonars_giftAI : public Scripted_NoMovementAI
    {
        mob_eonars_giftAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 Lifebinders_Gift_Timer;

        void Reset()
        {
            me->setFaction(16);
            DoCast(me, SPELL_GROW, true);
            DoCast(me, SPELL_PHEROMONES, true);
            DoCast(me, SPELL_EONAR_VISUAL, true);
            Lifebinders_Gift_Timer = 12000;
        }

        void UpdateAI(const uint32 diff)
        {
            if (instance && instance->GetBossState(BOSS_FREYA) != IN_PROGRESS)
                me->DisappearAndDie();

            if (Lifebinders_Gift_Timer <= diff)
            {
                me->RemoveAurasDueToSpell(SPELL_GROW);
                DoCast(RAID_MODE(SPELL_LIFEBINDERS_GIFT_10, SPELL_LIFEBINDERS_GIFT_25));
                me->DespawnOrUnsummon(2500);
                Lifebinders_Gift_Timer = 6000;
            }
            else {Lifebinders_Gift_Timer -= diff;}
        }
    };
};

// Sunbeam Freya
class mob_freya_sunbeam : public CreatureScript
{
    public:
      mob_freya_sunbeam() : CreatureScript("mob_freya_sunbeam") { }

        struct mob_freya_sunbeamAI : public Scripted_NoMovementAI
        {
            mob_freya_sunbeamAI(Creature* creature) : Scripted_NoMovementAI(creature) { }

            void Reset()
            {
                _unstableEnergyTimer = 1000;
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                me->SetDisplayId(MODEL_INVISIBLE);
                me->setFaction(16);
                me->DespawnOrUnsummon(12000);
                DoCast(me, 62216, true); // visual
            }

            void UpdateAI(uint32 const diff)
            {
                if (_unstableEnergyTimer <= diff)
				{
                    DoCast(RAID_MODE(SPELL_FREYA_UNSTABLE_ENERGY_10, SPELL_FREYA_UNSTABLE_ENERGY_25));
                    _unstableEnergyTimer = 15000;
               }
                else
                    _unstableEnergyTimer -= diff;
            }

        private:
            uint32 _unstableEnergyTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_freya_sunbeamAI(creature);
        }
};

// Freya HM and Elder Ironbranch
class mob_iron_roots : public CreatureScript
{
    public:
        mob_iron_roots() : CreatureScript("mob_iron_roots") { }

        struct mob_iron_rootsAI : public ScriptedAI
        {
            mob_iron_rootsAI(Creature* creature) : ScriptedAI(creature)
            {
                SetImmuneToPushPullEffects(true);
            }

            void Reset()
            {
                std::list<Player*> plrList = me->GetNearestPlayersList(20);
                for (std::list<Player*>::const_iterator itr = plrList.begin(); itr != plrList.end(); ++itr)
                    if ((*itr) && ((*itr)->HasAura(RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25)) || (*itr)->HasAura(RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25))))
                        _RootsGUID = (*itr)->GetGUID();
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Unit* Roots = Unit::GetUnit((*me), _RootsGUID))
                {
                    if (Roots->HasAura(RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25)))
                        Roots->RemoveAura(RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25));
                    if (Roots->HasAura(RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25)))
                        Roots->RemoveAura(RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25));
              }

                me->DespawnOrUnsummon(2000);
            }

            void UpdateAI(uint32 const /*diff*/) { }

        private:
            uint64 _RootsGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_iron_rootsAI(creature);
        }
};

class IsNoAllyOfNature
{
    public:
        bool operator() (Unit* unit)
        {
            if (unit->ToCreature())
            {
                switch (unit->ToCreature()->GetEntry())
                {
                    case 33088: // Iron Roots
                    case 33168: // Strengthened Iron Roots
                    case 32918: // Detonating Lasher
                    case 33202: // Ancient Water Spirit
                    case 32919: // Storm Lasher
                    case 32916: // Snaplasher
                    case 33203: // Ancient Conservator
                        return false;
                    default:
                        break;
                }
            }
            return true;
        }
};

class spell_elder_ironbranchs_essence_targeting : public SpellScriptLoader
{
    public:
        spell_elder_ironbranchs_essence_targeting() : SpellScriptLoader("spell_elder_ironbranchs_essence_targeting") { }

        class spell_elder_ironbranchs_essence_targeting_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_elder_ironbranchs_essence_targeting_SpellScript);

            void FilterTargets(std::list<Unit*>& unitList)
            {
                unitList.remove_if(IsNoAllyOfNature());
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_elder_ironbranchs_essence_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_elder_ironbranchs_essence_targeting_SpellScript();
        }
};

class spell_elder_brightleafs_essence_targeting : public SpellScriptLoader
{
    public:
        spell_elder_brightleafs_essence_targeting() : SpellScriptLoader("spell_elder_brightleafs_essence_targeting") { }

        class spell_elder_brightleafs_essence_targeting_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_elder_brightleafs_essence_targeting_SpellScript);

            void FilterTargetsEffect0(std::list<Unit*>& unitList)
            {
                unitList.remove_if(IsNoAllyOfNature());
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_elder_brightleafs_essence_targeting_SpellScript::FilterTargetsEffect0, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_elder_brightleafs_essence_targeting_SpellScript();
        }
};

class spell_aggregation_pheromones_targeting : public SpellScriptLoader
{
    public:
        spell_aggregation_pheromones_targeting() : SpellScriptLoader("spell_aggregation_pheromones_targeting") { }

        class spell_aggregation_pheromones_targeting_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_aggregation_pheromones_targeting_SpellScript);

            void FilterTargets(std::list<Unit*>& unitList)
            {
                // remove caster if this is the only target
                if (unitList.size() < 2)
                    unitList.clear();
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_aggregation_pheromones_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_aggregation_pheromones_targeting_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ALLY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_aggregation_pheromones_targeting_SpellScript::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_aggregation_pheromones_targeting_SpellScript();
        }
};

// temporary to trigger spell on proper target
class spell_elder_brightleaf_unstable_sun_beam : public SpellScriptLoader
{
    public:
        spell_elder_brightleaf_unstable_sun_beam() : SpellScriptLoader("spell_elder_brightleaf_unstable_sun_beam") { }

        class spell_elder_brightleaf_unstable_sun_beam_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_elder_brightleaf_unstable_sun_beam_SpellScript);

            void HandleForceCast(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Unit* caster = GetCaster();
                Unit* target = GetHitUnit();

                uint32 triggered_spell_id = GetSpellInfo()->Effects[effIndex].TriggerSpell;

                if (caster && target && triggered_spell_id)
                    target->CastSpell(target, triggered_spell_id, true, NULL, NULL, caster->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_elder_brightleaf_unstable_sun_beam_SpellScript::HandleForceCast, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
            }

            std::list<Unit*> sharedUnitList;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_elder_brightleaf_unstable_sun_beam_SpellScript();
        }
};

class achievement_getting_back_to_nature : public AchievementCriteriaScript
{
    public:
        achievement_getting_back_to_nature() : AchievementCriteriaScript("achievement_getting_back_to_nature")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            if (Creature* Freya = target->ToCreature())
                if (Freya->AI()->GetData(DATA_GETTING_BACK_TO_NATURE) >= 25)
                    return true;

            return false;
        }
};

class achievement_knock_on_wood : public AchievementCriteriaScript
{
   public:
       achievement_knock_on_wood() : AchievementCriteriaScript("achievement_knock_on_wood")
       {
       }

       bool OnCheck(Player* /*player*/, Unit* target)
       {
           if (!target)
               return false;

           if (Creature* Freya = target->ToCreature())
               if (Freya->AI()->GetData(DATA_KNOCK_ON_WOOD) >= 1)
                   return true;

           return false;
       }
};

class achievement_knock_knock_on_wood : public AchievementCriteriaScript
{
   public:
       achievement_knock_knock_on_wood() : AchievementCriteriaScript("achievement_knock_knock_on_wood")
       {
       }

       bool OnCheck(Player* /*player*/, Unit* target)
       {
           if (!target)
               return false;

           if (Creature* Freya = target->ToCreature())
               if (Freya->AI()->GetData(DATA_KNOCK_ON_WOOD) >= 2)
                   return true;

           return false;
       }
};

class achievement_knock_knock_knock_on_wood : public AchievementCriteriaScript
{
   public:
       achievement_knock_knock_knock_on_wood() : AchievementCriteriaScript("achievement_knock_knock_knock_on_wood")
       {
       }

       bool OnCheck(Player* /*player*/, Unit* target)
       {
           if (!target)
               return false;

           if (Creature* Freya = target->ToCreature())
               if (Freya->AI()->GetData(DATA_KNOCK_ON_WOOD) == 3)
                   return true;

           return false;
       }
};

/*
UPDATE creature_template SET ScriptName = "boss_freya" WHERE Entry = 32906;
UPDATE creature_template SET ScriptName = "mob_detonating_lasher" WHERE Entry = 32918;
UPDATE creature_template SET ScriptName = "mob_ancient_water_spirit" WHERE Entry = 33202;
UPDATE creature_template SET ScriptName = "mob_storm_lasher" WHERE Entry = 32919;
UPDATE creature_template SET ScriptName = "mob_snaplasher" WHERE Entry = 32916;
UPDATE creature_template SET ScriptName = "mob_ancient_conservator" WHERE Entry = 33203;
UPDATE creature_template SET ScriptName = "mob_healthy_spore" WHERE Entry = 33215;
UPDATE creature_template SET ScriptName = "mob_elder_brightleaf" WHERE Entry = 32915;
UPDATE creature_template SET ScriptName = "mob_elder_ironbranch" WHERE Entry = 32913;
UPDATE creature_template SET ScriptName = "mob_elder_stonebark" WHERE Entry = 32914;
UPDATE creature_template SET ScriptName = "mob_unstable_sunbeam" WHERE Entry = 33050;
UPDATE creature_template SET ScriptName = "mob_eonars_gift" WHERE Entry = 33228;
UPDATE creature_template SET ScriptName = "mob_natural_bomb" WHERE ENTRY = 34129;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33168;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33088;
UPDATE creature_template SET ScriptName = "mob_freya_sunbeam" WHERE Entry = 33170;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33168;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33088;
UPDATE creature_template SET faction_A = 16 WHERE Entry = 33168;
UPDATE creature_template SET faction_H = 16 WHERE Entry = 33168;

DELETE FROM spell_script_names WHERE spell_id IN (62623,62872);
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
(62623, "spell_freya_sunbeam"),
(62872, "spell_freya_sunbeam");
DELETE FROM spell_script_names WHERE spell_id = 64648;
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES (64648,"spell_freya_natural_bomb_spell");
DELETE FROM spell_script_names WHERE spell_id IN (62524,62525,62521);
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
(62524,"spell_attuned_to_nature_remove"),
(62525,"spell_attuned_to_nature_remove"),
(62521,"spell_attuned_to_nature_remove");
DELETE FROM spell_script_names WHERE spell_id = 62688;
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES (62688,"spell_summon_wave_effect_10mob");
*/

void AddSC_boss_freya()
{
    new boss_freya();
    new mob_natural_bomb();
    new spell_freya_natural_bomb_spell();
    new spell_attuned_to_nature_remove_spell();
    new spell_summon_wave_effect_10mob_spell();
    new mob_detonating_lasher();
    new mob_ancient_water_spirit();
    new mob_storm_lasher();
    new mob_snaplasher();
    new mob_ancient_conservator();
    new mob_elder_ironbranch();
    new mob_elder_stonebark();
    new mob_elder_brightleaf();
    new mob_unstable_sunbeam();
    new mob_eonars_gift();
    new mob_healthy_spore();
    new mob_freya_sunbeam();
    new mob_iron_roots();
    new spell_elder_ironbranchs_essence_targeting();
    new spell_elder_brightleafs_essence_targeting();
    new spell_aggregation_pheromones_targeting();
    new spell_elder_brightleaf_unstable_sun_beam();
    new achievement_getting_back_to_nature();
    new achievement_knock_on_wood();
    new achievement_knock_knock_on_wood();
    new achievement_knock_knock_knock_on_wood();
}
