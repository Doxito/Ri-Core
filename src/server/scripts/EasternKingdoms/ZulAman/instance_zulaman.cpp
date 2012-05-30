 /*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: instance_zulaman
SD%Complete: 80% to 95% (by reinosiberos.com)
SDComment:
SDCategory: Zul'Aman
EndScriptData 

Arreglos por reinosiberos.com  :
Recreado totalmente el evento inicial de la mazmorra llegando a solucionar 90% del fallo que tenía
Modificada la flag del gong para que este pueda ser usado
Eliminados npc's mal posicionados a la entrada de la instance
Arreglado bug visual del arma de Malacrass
Añadida puerta de después de Malacrass
Abrir puerta de después de Malacrass tras derrotar a este
*/

#include "ScriptPCH.h"
#include "zulaman.h"

#define MAX_ENCOUNTER     6
#define RAND_VENDOR    2

//187021 //Harkor's Satchel
//186648 //Tanzar's Trunk
//186672 //Ashli's Bag
//186667 //Kraz's Package
// Chests spawn at bear/eagle/dragonhawk/lynx bosses
// The loots depend on how many bosses have been killed, but not the entries of the chests
// But we cannot add loots to gameobject, so we have to use the fixed loot_template
struct SHostageInfo
{
    uint32 npc, go; // FIXME go Not used
    float x, y, z, o;
};

static SHostageInfo HostageInfo[] =
{
    {23790, 186648, -57, 1343, 40.77f, 3.2f}, // bear
    {23999, 187021, 400, 1414, 74.36f, 3.3f}, // eagle
    {24001, 186672, -35, 1134, 18.71f, 1.9f}, // dragonhawk
    {24024, 186667, 413, 1117,  6.32f, 3.1f}  // lynx

};

class instance_zulaman : public InstanceMapScript
{
    public:
        instance_zulaman()
            : InstanceMapScript("instance_zulaman", 568)
        {
        }

        struct instance_zulaman_InstanceMapScript : public InstanceScript
        {
            instance_zulaman_InstanceMapScript(Map* map) : InstanceScript(map) {}

            uint64 HarkorsSatchelGUID;
            uint64 TanzarsTrunkGUID;
            uint64 AshlisBagGUID;
            uint64 KrazsPackageGUID;

            uint64 HexLordGateGUID;
            uint64 ZulJinGateGUID;
            uint64 AkilzonDoorGUID;
            uint64 ZulJinDoorGUID;
            uint64 HalazziDoorGUID;
			uint64 StartGateGUID;

            uint32 QuestTimer;
            uint16 BossKilled;
            uint16 QuestMinute;
            uint16 ChestLooted;

            uint32 m_auiEncounter[MAX_ENCOUNTER];
            uint32 RandVendor[RAND_VENDOR];
			
			bool opendoor;
			bool control;

            void Initialize()
            {
                memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

                HarkorsSatchelGUID = 0;
                TanzarsTrunkGUID = 0;
                AshlisBagGUID = 0;
                KrazsPackageGUID = 0;

                HexLordGateGUID = 0;
                ZulJinGateGUID = 0;
                AkilzonDoorGUID = 0;
                HalazziDoorGUID = 0;
                ZulJinDoorGUID = 0;
				StartGateGUID = 0;

                QuestTimer = 0;
                QuestMinute = 21;
                BossKilled = 0;
                ChestLooted = 0;
				opendoor = false;
				control = false;
				
                for (uint8 i = 0; i < RAND_VENDOR; ++i)
                    RandVendor[i] = NOT_STARTED;
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
                case 23578://janalai
                case 23863://zuljin
                case 24239://hexlord
                case 23577://halazzi
                case 23576://nalorakk
                default: break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                case 186303: HalazziDoorGUID = go->GetGUID(); break;
                case 186304: ZulJinGateGUID  = go->GetGUID(); break;
                case 186305: HexLordGateGUID = go->GetGUID(); break;
                case 186858: AkilzonDoorGUID = go->GetGUID(); break;
                case 186859: ZulJinDoorGUID  = go->GetGUID(); break;
				case 186728: StartGateGUID = go->GetGUID(); break;
                case 187021: HarkorsSatchelGUID  = go->GetGUID(); break;
                case 186648: TanzarsTrunkGUID = go->GetGUID(); break;
                case 186672: AshlisBagGUID = go->GetGUID(); break;
                case 186667: KrazsPackageGUID  = go->GetGUID(); break;
                default: break;

                }
                CheckInstanceStatus();
            }

            void SummonHostage(uint8 num)
            {
                if (!QuestMinute)
                    return;

                Map::PlayerList const &PlayerList = instance->GetPlayers();
                if (PlayerList.isEmpty())
                    return;

                Map::PlayerList::const_iterator i = PlayerList.begin();
                if (Player* i_pl = i->getSource())
                {
                    if (Unit* Hostage = i_pl->SummonCreature(HostageInfo[num].npc, HostageInfo[num].x, HostageInfo[num].y, HostageInfo[num].z, HostageInfo[num].o, TEMPSUMMON_DEAD_DESPAWN, 0))
                    {
                        Hostage->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        Hostage->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
            }

            void CheckInstanceStatus()
            {
                if (opendoor)
                    HandleGameObject(StartGateGUID, true);			
					
                if (BossKilled >= 4)
                    HandleGameObject(HexLordGateGUID, true);

                if (BossKilled >= 5)
                    HandleGameObject(ZulJinGateGUID, true);
            }

            std::string GetSaveData()
            {
                std::ostringstream ss;
                ss << "S " << BossKilled << ' ' << ChestLooted << ' ' << QuestMinute << ' ' << opendoor;
                char* data = new char[ss.str().length()+1];
                strcpy(data, ss.str().c_str());
                //sLog->outError("TSCR: Zul'aman saved, %s.", data);
                return data;
            }

            void Load(const char* load)
            {
                if (!load) return;
                std::istringstream ss(load);
                //sLog->outError("TSCR: Zul'aman loaded, %s.", ss.str().c_str());
                char dataHead; // S
                uint16 data1, data2, data3, data4;
                ss >> dataHead >> data1 >> data2 >> data3 >> data4;
                //sLog->outError("TSCR: Zul'aman loaded, %d %d %d.", data1, data2, data3);
                if (dataHead == 'S')
                {
                    BossKilled = data1;
                    ChestLooted = data2;
                    QuestMinute = data3;
					opendoor = data4;
                } else sLog->outError("TSCR: Zul'aman: corrupted save data.");
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                case DATA_NALORAKKEVENT:
                    m_auiEncounter[0] = data;
                    if (data == DONE)
                    {
                        if (QuestMinute)
                        {
                            QuestMinute += 15;
                            DoUpdateWorldState(3106, QuestMinute);
                        }
                        SummonHostage(0);
						control = false;
                    }
                    break;
                case DATA_AKILZONEVENT:
                    m_auiEncounter[1] = data;
                    HandleGameObject(AkilzonDoorGUID, data != IN_PROGRESS);
                    if (data == DONE)
                    {
                        if (QuestMinute)
                        {
                            QuestMinute += 10;
                            DoUpdateWorldState(3106, QuestMinute);
                        }
                        SummonHostage(1);
						control = false;
					}
                    break;
                case DATA_JANALAIEVENT:
                    m_auiEncounter[2] = data;
                    if (data == DONE) 
					{
					SummonHostage(2);
                    control = false;
					}
					break;
                case DATA_HALAZZIEVENT:
                    m_auiEncounter[3] = data;
                    HandleGameObject(HalazziDoorGUID, data != IN_PROGRESS);
                    if (data == DONE)
					{
					SummonHostage(3);
                    control = false;
					}
					break;
                case DATA_HEXLORDEVENT:
                    m_auiEncounter[4] = data;
                    if (data == IN_PROGRESS)
                        HandleGameObject(HexLordGateGUID, false);
                    else if (data == NOT_STARTED)
                        CheckInstanceStatus();
                    break;
                case DATA_STARTDOOR  :
                    if (data == DONE)
					{
						opendoor = true;
						control = true;
						CheckInstanceStatus();
						SaveToDB();
					}
					break;
                case DATA_ZULJINEVENT:
                    m_auiEncounter[5] = data;
                    HandleGameObject(ZulJinDoorGUID, data != IN_PROGRESS);
                    break;
                case DATA_CHESTLOOTED:
                    ++ChestLooted;
                    SaveToDB();
                    break;
                case TYPE_RAND_VENDOR_1:
                    RandVendor[0] = data;
                    break;
                case TYPE_RAND_VENDOR_2:
                    RandVendor[1] = data;
                    break;
                }

                if (data == DONE && !control)
                {
                    ++BossKilled;
                    if (QuestMinute && BossKilled >= 4)
                    {
                        QuestMinute = 0;
                        DoUpdateWorldState(3104, 0);
                    }
                    CheckInstanceStatus();
                    SaveToDB();
                }
            }

            uint32 GetData(uint32 type)
            {
                switch (type)
                {
                case DATA_NALORAKKEVENT: return m_auiEncounter[0];
                case DATA_AKILZONEVENT:  return m_auiEncounter[1];
                case DATA_JANALAIEVENT:  return m_auiEncounter[2];
                case DATA_HALAZZIEVENT:  return m_auiEncounter[3];
                case DATA_HEXLORDEVENT:  return m_auiEncounter[4];
                case DATA_ZULJINEVENT:   return m_auiEncounter[5];
                case DATA_CHESTLOOTED:   return ChestLooted;
                case TYPE_RAND_VENDOR_1: return RandVendor[0];
                case TYPE_RAND_VENDOR_2: return RandVendor[1];
                default:                 return 0;
                }
            }

            void Update(uint32 diff)
            {
                if (QuestMinute)
                {
                    if (QuestTimer <= diff)
                    {
                        QuestMinute--;
                        SaveToDB();
                        QuestTimer += 60000;
                        if (QuestMinute)
                        {
                            DoUpdateWorldState(3104, 1);
                            DoUpdateWorldState(3106, QuestMinute);
                        } else DoUpdateWorldState(3104, 0);
                    }
                    QuestTimer -= diff;
                }
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_zulaman_InstanceMapScript(map);
        }
};

#define GONG              "Seg""\xC3\xBA""n mis c""\xC3\xA1""lculos al golpear el gong los habitantes de la ciudad lo escuchar""\xC3\xA1""n y abrir""\xC3\xA1""n la puerta"
#define MUERTE				"""\xc2\xa1""Emboscada!"
#define GOSSIP_ITEM     "Estamos preparados, abre la puerta"

class harrison_jones : public CreatureScript
{
    public:

        harrison_jones()
            : CreatureScript("harrison_jones")
        {
        }

        struct harrison_jonesAI : public ScriptedAI
        {
            harrison_jonesAI(Creature* c) : ScriptedAI(c) { instance = c->GetInstanceScript(); }
			
			InstanceScript* instance;

			uint32 attacktime;
			uint32 timehit;
			uint32 wait;
			uint32 morir;
			
			bool attack;
			bool checksummon;
			bool opendoor;
			bool hit;
			bool final;
			bool definitiveopen;
			bool segundoevento;
			bool muere;
			
            void Reset()
            {
				definitiveopen = false;
				checksummon = false;
				attack 	= false;
				hit 	= true;
				final = false;
				segundoevento = false;
				muere = false;
            }
			
			void UpdateAI(const uint32 uiDiff)
            {
			
			if (segundoevento)
			{
				if (Creature* trigger = me->SummonCreature(23597, 129.7857f, 1587.3504f, 43.5458f, 3.0740f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}
					
				if (Creature* trigger = me->SummonCreature(23597, 110.8877f, 1586.6760f, 43.5278f, 0.0659f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}				
		
				if (Creature* trigger = me->SummonCreature(23889, 108.92f, 1573.36f, 43.52f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}
					
				if (Creature* trigger = me->SummonCreature(23889, 113.24f, 1573.12f, 43.50f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}
					
				if (Creature* trigger = me->SummonCreature(23889, 118.01f, 1572.85f, 43.49f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}
					
				if (Creature* trigger = me->SummonCreature(23889, 122.78f, 1572.59f, 43.49f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}

				if (Creature* trigger = me->SummonCreature(23889, 127.80f, 1572.31f, 43.51f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}					

				if (Creature* trigger = me->SummonCreature(23889, 131.88f, 1572.08f, 43.53f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}

				if (Creature* trigger = me->SummonCreature(23889, 111.15f, 1576.76f, 43.49f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}				

				if (Creature* trigger = me->SummonCreature(23889, 115.58f, 1576.78f, 43.47f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}				

				if (Creature* trigger = me->SummonCreature(23889, 120.71f, 1576.80f, 43.46f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}

				if (Creature* trigger = me->SummonCreature(23889, 125.37f, 1576.82f, 43.47f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}

				if (Creature* trigger = me->SummonCreature(23889, 129.92f, 1576.84f, 43.49f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN))
				{
					trigger->SetInCombatWithZone();
					trigger->DespawnOrUnsummon(3000000);
				}				
			}			

			if (attack)
			{				
				if (hit)
				{
					me->HandleEmoteCommand(51);
				}
				
				if(attacktime <= uiDiff)
					{attack = false; opendoor = true; final = true;}
				else attacktime -= uiDiff;
				
				if(timehit <= uiDiff)
					{hit = false;}
				else timehit -= uiDiff;
			} 
			
			
			if(me->GetPositionX() == 132.80f || me->GetPositionY() == 1641.21f || me->GetPositionZ() == 42.02f)
			{	
				if (!checksummon)
				{
					if (Creature* trigger = me->SummonCreature(25173, 133.5937f, 1641.2270f, 42.0216f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN)) 
					{
					me->MonsterYell(GONG, LANG_UNIVERSAL, 0);
					checksummon = true;
					me->SetTarget(trigger->GetGUID());
					trigger->DespawnOrUnsummon(15000);
					attacktime = 15000;
					timehit = 13000;
					wait = 10000;
					attack = true;
					}
				}
						
			}
			
			if (opendoor && final)
				{
				me->GetMotionMaster()->MovePoint(0, 120.58f, 1610.43f, 43.48f);
				}
			
			if(me->GetPositionX() == 120.58f || me->GetPositionY() == 1610.43f || me->GetPositionZ() == 43.48f)
				{
				me->HandleEmoteCommand(69);
				
				if(wait <= uiDiff)
					{definitiveopen = true;}
				else wait -= uiDiff;
				
				if (definitiveopen)
				{
                instance->SetData(DATA_STARTDOOR, DONE);
				me->GetMotionMaster()->MovePoint(0, 120.42f, 1587.71f, 43.42f);
				morir = 50;
				final = false;
				}
				}
			if(me->GetPositionX() == 120.42f || me->GetPositionY() == 1587.71f || me->GetPositionZ() == 43.42f)	
				{
				segundoevento = true;
				if (muere)
				{
				me->MonsterYell(MUERTE, LANG_UNIVERSAL, 0);
				me->setDeathState(JUST_DIED);
				}
				
				if(morir <= uiDiff)
					{muere = true;}
				else morir -= uiDiff;
				
				}
			}
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new harrison_jonesAI(creature);
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(907, creature->GetGUID());
			
            return true;
			
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();
            if (action == GOSSIP_ACTION_INFO_DEF+1)
            {
                player->CLOSE_GOSSIP_MENU();
				creature->GetMotionMaster()->MovePoint(0, 132.80f, 1641.21f, 42.02f);
				creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            return true;
        }
};

void AddSC_instance_zulaman()
{
	new harrison_jones();
    new instance_zulaman();
}

