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
#include "CreatureTextMgr.h"
#include "culling_of_stratholme.h"

#define MAX_ENCOUNTER 7

/* Culling of Stratholme encounters:
0 - Plague Crates
1 - Meathook
2 - Salramm the Fleshcrafter
3 - Chrono-Lord Epoch
4 - Mal'Ganis
5 - Infinite Corruptor (Heroic only)
6 - Arthas
*/

class instance_culling_of_stratholme : public InstanceMapScript
{
public:
    instance_culling_of_stratholme() : InstanceMapScript("instance_culling_of_stratholme", 595) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_culling_of_stratholme_InstanceMapScript(map);
    }

    struct instance_culling_of_stratholme_InstanceMapScript : public InstanceScript
    {
        instance_culling_of_stratholme_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint64 uiArthas;
        uint64 uiMeathook;
        uint64 uiSalramm;
        uint64 uiEpoch;
        uint64 uiMalGanis;
        uint64 uiInfinite;

        uint64 uiShkafGate;
        uint64 uiMalGanisGate1;
        uint64 uiMalGanisGate2;
        uint64 uiExitGate;
        uint64 uiMalGanisChest;
        uint32 uiCountdownTimer;
        uint16 uiCountdownMinute;

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        uint32 uiCountCrates;


        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            uiCountCrates = 0;
            uiCountdownTimer = 0;
            uiCountdownMinute = 26;
        }


        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_ARTHAS:
                    uiArthas = creature->GetGUID();
                    break;
                case NPC_MEATHOOK:
                    uiMeathook = creature->GetGUID();
                    break;
                case NPC_SALRAMM:
                    uiSalramm = creature->GetGUID();
                    break;
                case NPC_EPOCH:
                    uiEpoch = creature->GetGUID();
                    break;
                case NPC_MAL_GANIS:
                    uiMalGanis = creature->GetGUID();
                    break;
                case NPC_INFINITE:
                    uiInfinite = creature->GetGUID();
                    creature->SetVisible(false);
                    creature->setFaction(35);
                    break;
                case NPC_ZOMBIE:
                    if (m_auiEncounter[6] == NOT_STARTED && creature->GetPositionX() < 2205.0f && creature->GetPositionY() < 1320.0f)
                        creature->UpdateEntry(roll_chance_i(50) ? 28167 : 28169);
                    creature->SetCorpseDelay(3);
                    break;
            }
        }

        // Give reward needed for Zombiefest achievement to players out of normal reward distance
        void OnCreatureDeath(Creature* creature)
        {
            if (creature->GetEntry() == NPC_ZOMBIE)
            {
                Map::PlayerList const &PlayerList = instance->GetPlayers();

                if (PlayerList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    if (Player* player = i->getSource())
                    {
                        if (player->IsAtGroupRewardDistance(creature)) // already handled
                            continue;

                        if (player->isAlive() || !player->GetCorpse())
                            player->KilledMonsterCredit(NPC_ZOMBIE, 0);
                    }
            }
        }

        void GiveQuestKillAllInInstance(uint32 entry)
        {
            Map::PlayerList const &PlayerList = instance->GetPlayers();

            if (PlayerList.isEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* player = i->getSource())
                    player->KilledMonsterCredit(entry, 0);
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_SHKAF_GATE:
                    uiShkafGate = go->GetGUID();
                    break;
                case GO_MALGANIS_GATE_1:
                    uiMalGanisGate1 = go->GetGUID();
                    break;
                case GO_MALGANIS_GATE_2:
                    uiMalGanisGate2 = go->GetGUID();
                    break;
                case GO_EXIT_GATE:
                    uiExitGate = go->GetGUID();
                    if (m_auiEncounter[4] == DONE)
                        HandleGameObject(uiExitGate, true);
                    break;
                case GO_MALGANIS_CHEST_N:
                case GO_MALGANIS_CHEST_H:
                    uiMalGanisChest = go->GetGUID();
                    if (m_auiEncounter[4] == DONE)
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {
                case DATA_CRATES_EVENT:
                    switch (data)
                    {
                        case 0: // Entfernt Worldstate
                            DoUpdateWorldState(WORLDSTATE_NUMBER_CRATES_SHOW, 0);
                            break;
                        case 1: // Addiert ein Punkt
                            ++uiCountCrates;
                            DoUpdateWorldState(WORLDSTATE_NUMBER_CRATES_COUNT, uiCountCrates);
                            if (uiCountCrates >= 5)
                            {
                                m_auiEncounter[0] = DONE;
                                GiveQuestKillAllInInstance(CREDIT_DISPELLING_ILLUSIONS);
                                SaveToDB();
                            }
                            break;
                        case 2: // Startet den Worldstate
                            uiCountCrates = 0;
                            m_auiEncounter[0] = IN_PROGRESS;
                            DoUpdateWorldState(WORLDSTATE_NUMBER_CRATES_SHOW, 1);
                            DoUpdateWorldState(WORLDSTATE_NUMBER_CRATES_COUNT, uiCountCrates);
                            break;
                    }
                    break;
                case DATA_MEATHOOK_EVENT:
                    m_auiEncounter[1] = data;
                    break;
                case DATA_SALRAMM_EVENT:
                    m_auiEncounter[2] = data;
                    break;
                case DATA_EPOCH_EVENT:
                    m_auiEncounter[3] = data;
                    break;
                case DATA_MAL_GANIS_EVENT:
                    m_auiEncounter[4] = data;
                    switch (data)
                    {
                        case NOT_STARTED:
                            HandleGameObject(uiMalGanisGate2, true);
                            break;
                        case IN_PROGRESS:
                            HandleGameObject(uiMalGanisGate2, false);
                            break;
                        case DONE:
                            GiveQuestKillAllInInstance(CREDIT_A_ROYAL_ESCORT);
                            HandleGameObject(uiExitGate, true);
                            HandleGameObject(uiMalGanisGate2, true);
                            if (GameObject* go = instance->GetGameObject(uiMalGanisChest))
                                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                            break;
                    }
                    break;
                case DATA_INFINITE_EVENT:
                    m_auiEncounter[5] = data;
                    switch (data)
                    {
                        case DONE:
                            uiCountdownMinute = 0;
                            DoUpdateWorldState(WORLDSTATE_NUMBER_INFINITE_SHOW, 0);
                            break;
                        case IN_PROGRESS: // make visible
                        {
                            if (Creature* creature = instance->GetCreature(uiInfinite))
                            {
                                creature->SetVisible(true);
                                creature->RestoreFaction();
                            }
                            break;
                        }
                    }
                    break;
                case DATA_ARTHAS_EVENT:
                    m_auiEncounter[6] = data;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type)
        {
            switch (type)
            {
                case DATA_CRATES_EVENT:               return m_auiEncounter[0];
                case DATA_MEATHOOK_EVENT:             return m_auiEncounter[1];
                case DATA_SALRAMM_EVENT:              return m_auiEncounter[2];
                case DATA_EPOCH_EVENT:                return m_auiEncounter[3];
                case DATA_MAL_GANIS_EVENT:            return m_auiEncounter[4];
                case DATA_INFINITE_EVENT:             return m_auiEncounter[5];
                case DATA_ARTHAS_EVENT:               return m_auiEncounter[6];
                case DATA_COUNTDOWN:                  return uiCountdownMinute;
            }
            return 0;
        }

        uint64 GetData64(uint32 identifier)
        {
            switch (identifier)
            {
                case DATA_ARTHAS:                     return uiArthas;
                case DATA_MEATHOOK:                   return uiMeathook;
                case DATA_SALRAMM:                    return uiSalramm;
                case DATA_EPOCH:                      return uiEpoch;
                case DATA_MAL_GANIS:                  return uiMalGanis;
                case DATA_INFINITE:                   return uiInfinite;
                case DATA_SHKAF_GATE:                 return uiShkafGate;
                case DATA_MAL_GANIS_GATE_1:           return uiMalGanisGate1;
                case DATA_MAL_GANIS_GATE_2:           return uiMalGanisGate2;
                case DATA_EXIT_GATE:                  return uiExitGate;
                case DATA_MAL_GANIS_CHEST:            return uiMalGanisChest;
            }
            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "C S " << m_auiEncounter[0] << " " << m_auiEncounter[1] << " "
                << m_auiEncounter[2] << " " << m_auiEncounter[3] << " " << m_auiEncounter[4] << " " << m_auiEncounter[5] << " " << m_auiEncounter[6] << " " << uiCountdownMinute;

            str_data = saveStream.str();

            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0, data1, data2, data3, data4, data5, data6, data7;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4 >> data5 >> data6 >> data7;

            if (dataHead1 == 'C' && dataHead2 == 'S')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                m_auiEncounter[3] = data3;
                m_auiEncounter[4] = data4;
                m_auiEncounter[5] = data5;
                m_auiEncounter[6] = data6;
                uiCountdownMinute = data7;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS || m_auiEncounter[i] == SPECIAL)
                        m_auiEncounter[i] = NOT_STARTED;

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void Update(uint32 diff)
        {
            if (GetData(DATA_INFINITE_EVENT) == SPECIAL || GetData(DATA_INFINITE_EVENT) == IN_PROGRESS)
                if (uiCountdownMinute)
                {
                    if (uiCountdownTimer < diff)
                    {
                        --uiCountdownMinute;

                        if (uiCountdownMinute)
                        {
                            DoUpdateWorldState(WORLDSTATE_NUMBER_INFINITE_SHOW, 1);
                            DoUpdateWorldState(WORLDSTATE_NUMBER_INFINITE_TIMER, uiCountdownMinute);
                        }
                        else
                        {
                            DoUpdateWorldState(WORLDSTATE_NUMBER_INFINITE_SHOW, 0);
                        }
                        SaveToDB();
                        uiCountdownTimer += 60000;
                    }
                    uiCountdownTimer -= diff;
                }
        }
    };
};

void AddSC_instance_culling_of_stratholme()
{
    new instance_culling_of_stratholme();
}
