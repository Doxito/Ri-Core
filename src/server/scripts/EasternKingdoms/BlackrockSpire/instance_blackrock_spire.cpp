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
#include "blackrock_spire.h"

class instance_blackrock_spire : public InstanceMapScript
{
public:
    instance_blackrock_spire() : InstanceMapScript("instance_blackrock_spire", 229) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_blackrock_spireMapScript(map);
    }

    struct instance_blackrock_spireMapScript : public InstanceScript
    {
        instance_blackrock_spireMapScript(InstanceMap* map) : InstanceScript(map) {}

        uint32 encounter[MAX_ENCOUNTER];
		uint32 m_uiManyWhelpsCounter;
		uint32 m_uiOnyxiaLiftoffTimer;
        std::string m_strInstData;
        uint64 HighlordOmokk;
        uint64 ShadowHunterVoshgajin;
        uint64 WarMasterVoone;
        uint64 MotherSmolderweb;
        uint64 UrokDoomhowl;
        uint64 QuartermasterZigris;
        uint64 GizrultheSlavener;
        uint64 Halycon;
        uint64 OverlordWyrmthalak;
        uint64 PyroguardEmberseer;
        uint64 WarchiefRendBlackhand;
        uint64 Gyth;
        uint64 TheBeast;
        uint64 GeneralDrakkisath;
		
		bool   m_bAchievManyWhelpsHandleIt;

        void Initialize()
        {
            SetBossNumber(MAX_ENCOUNTER);
			uint32 m_uiOnyxiaLiftoffTimer = 0;
            HighlordOmokk           = 0;
			m_uiManyWhelpsCounter   = 0;
            ShadowHunterVoshgajin   = 0;
            WarMasterVoone          = 0;
            MotherSmolderweb        = 0;
            UrokDoomhowl            = 0;
            QuartermasterZigris     = 0;
            GizrultheSlavener       = 0;
            Halycon                 = 0;
            OverlordWyrmthalak      = 0;
            PyroguardEmberseer      = 0;
            WarchiefRendBlackhand   = 0;
            Gyth                    = 0;
            TheBeast                = 0;
            GeneralDrakkisath       = 0;
			m_bAchievManyWhelpsHandleIt = false;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (encounter[i] == IN_PROGRESS)
                    return true;
            }
            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_OMOKK:
                    HighlordOmokk = creature->GetGUID();
                    break;
                case NPC_SHADOW_HUNTER_VOSHGAJIN:
                    ShadowHunterVoshgajin = creature->GetGUID();
                    break;
                case NPC_WARMASTER_VOONE:
                    WarMasterVoone = creature->GetGUID();
                    break;
                case NPC_MOTHER_SMOLDERWEB:
                    MotherSmolderweb = creature->GetGUID();
                    break;
                case NPC_UROK_DOOMHOWL:
                    UrokDoomhowl = creature->GetGUID();
                    break;
                case NPC_QUARTERMASTER_ZIGRIS:
                    QuartermasterZigris = creature->GetGUID();
                    break;
                case NPC_GIZRUL_THE_SLAVENER:
                    GizrultheSlavener = creature->GetGUID();
                    break;
                case  NPC_HALYCON:
                    Halycon = creature->GetGUID();
                    break;
                case  NPC_OVERLORD_WYRMTHALAK:
                    OverlordWyrmthalak = creature->GetGUID();
                    break;
                case  NPC_PYROGAURD_EMBERSEER:
                    PyroguardEmberseer = creature->GetGUID();
                    break;
                case  NPC_WARCHIEF_REND_BLACKHAND:
                    WarchiefRendBlackhand = creature->GetGUID();
                    break;
                case NPC_GYTH:
                    Gyth = creature->GetGUID();
                    break;
                case NPC_THE_BEAST:
                    TheBeast = creature->GetGUID();
                    break;
                case NPC_GENERAL_DRAKKISATH:
                    GeneralDrakkisath = creature->GetGUID();
                    break;
            }
         }

        void SetData(uint32 uiType, uint32 uiData)
        {
            switch (uiType)
            {
					case DATA_PHASE_LEEROY:
                        m_bAchievManyWhelpsHandleIt = false;
                        m_uiManyWhelpsCounter = 0;
                        m_uiOnyxiaLiftoffTimer = 15*IN_MILLISECONDS;
					break;
            }

            if (uiType < MAX_ENCOUNTER && uiData == DONE)
                SaveToDB();
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_WHELP_SPAWNER:
					Position goPos;
                    go->GetPosition(&goPos);
                    if (Creature* temp = go->SummonCreature(NPC_WHELP, goPos, TEMPSUMMON_CORPSE_DESPAWN))
                    {
                        temp->SetInCombatWithZone();
                        ++m_uiManyWhelpsCounter;
                    }
                    break;
            }
        }
		
        void Update(uint32 uiDiff)
        {
                if (m_uiOnyxiaLiftoffTimer && m_uiOnyxiaLiftoffTimer <= uiDiff)
                {
                    m_uiOnyxiaLiftoffTimer = 0;
                    if (m_uiManyWhelpsCounter >= 50)
                        m_bAchievManyWhelpsHandleIt = true;
                } else m_uiOnyxiaLiftoffTimer -= uiDiff;
        }

        bool SetBossState(uint32 type, EncounterState state)
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_OMOKK:
                case DATA_SHADOW_HUNTER_VOSHGAJIN:
                case DATA_WARMASTER_VOONE:
                case DATA_MOTHER_SMOLDERWEB:
                case DATA_UROK_DOOMHOWL:
                case DATA_QUARTERMASTER_ZIGRIS:
                case DATA_GIZRUL_THE_SLAVENER:
                case DATA_HALYCON:
                case DATA_OVERLORD_WYRMTHALAK:
                case DATA_PYROGAURD_EMBERSEER:
                case DATA_WARCHIEF_REND_BLACKHAND:
                case DATA_GYTH:
                case DATA_THE_BEAST:
                case DATA_GENERAL_DRAKKISATH:
                    break;
                default:
                    break;
            }

             return true;
        }

        uint64 GetData64(uint32 type)
        {
            switch (type)
            {
                case DATA_OMOKK:
                    return HighlordOmokk;
                case DATA_SHADOW_HUNTER_VOSHGAJIN:
                    return ShadowHunterVoshgajin;
                case DATA_WARMASTER_VOONE:
                    return WarMasterVoone;
                case DATA_MOTHER_SMOLDERWEB:
                    return MotherSmolderweb;
                case DATA_UROK_DOOMHOWL:
                    return UrokDoomhowl;
                case DATA_QUARTERMASTER_ZIGRIS:
                    return QuartermasterZigris;
                case DATA_GIZRUL_THE_SLAVENER:
                    return GizrultheSlavener;
                case DATA_HALYCON:
                    return Halycon;
                case DATA_OVERLORD_WYRMTHALAK:
                    return OverlordWyrmthalak;
                case DATA_PYROGAURD_EMBERSEER:
                    return PyroguardEmberseer;
                case DATA_WARCHIEF_REND_BLACKHAND:
                    return WarchiefRendBlackhand;
                case DATA_GYTH:
                    return Gyth;
                case DATA_THE_BEAST:
                    return TheBeast;
                case DATA_GENERAL_DRAKKISATH:
                    return GeneralDrakkisath;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "B S " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'B' && dataHead2 == 'S')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                }
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }
		
        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target*/ = NULL, uint32 /*miscvalue1*/ = 0)
        {
            switch (criteria_id)
            {
                case ACHIEV_CRITERIA_LEEEEROY: // Criteria for achievement 2188: ¡Leeeeeeeeeeeeeroy! Hatch 50 eggs in 15s
                    return m_bAchievManyWhelpsHandleIt;
            }
            return false;
        }
    };

};

void AddSC_instance_blackrock_spire()
{
    new instance_blackrock_spire();
}
