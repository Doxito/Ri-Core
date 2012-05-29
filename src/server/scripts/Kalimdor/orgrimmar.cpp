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
SDName: Orgrimmar
SD%Complete: 100
SDComment: Quest support: 2460, 6566
SDCategory: Orgrimmar
EndScriptData */

/* ContentData
npc_shenthul
npc_thrall_warchief
EndContentData */

#include "ScriptPCH.h"

/*######
## npc_shenthul
######*/

enum eShenthul
{
    QUEST_SHATTERED_SALUTE  = 2460
};

class npc_shenthul : public CreatureScript
{
public:
    npc_shenthul() : CreatureScript("npc_shenthul") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_SHATTERED_SALUTE)
        {
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->CanTalk = true;
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->PlayerGUID = player->GetGUID();
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_shenthulAI (creature);
    }

    struct npc_shenthulAI : public ScriptedAI
    {
        npc_shenthulAI(Creature* c) : ScriptedAI(c) {}

        bool CanTalk;
        bool CanEmote;
        uint32 Salute_Timer;
        uint32 Reset_Timer;
        uint64 PlayerGUID;

        void Reset()
        {
            CanTalk = false;
            CanEmote = false;
            Salute_Timer = 6000;
            Reset_Timer = 0;
            PlayerGUID = 0;
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            if (CanEmote)
            {
                if (Reset_Timer <= diff)
                {
                    if (Player* player = Unit::GetPlayer(*me, PlayerGUID))
                    {
                        if (player->GetTypeId() == TYPEID_PLAYER && player->GetQuestStatus(QUEST_SHATTERED_SALUTE) == QUEST_STATUS_INCOMPLETE)
                            player->FailQuest(QUEST_SHATTERED_SALUTE);
                    }
                    Reset();
                } else Reset_Timer -= diff;
            }

            if (CanTalk && !CanEmote)
            {
                if (Salute_Timer <= diff)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    CanEmote = true;
                    Reset_Timer = 60000;
                } else Salute_Timer -= diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void ReceiveEmote(Player* player, uint32 emote)
        {
            if (emote == TEXT_EMOTE_SALUTE && player->GetQuestStatus(QUEST_SHATTERED_SALUTE) == QUEST_STATUS_INCOMPLETE)
            {
                if (CanEmote)
                {
                    player->AreaExploredOrEventHappens(QUEST_SHATTERED_SALUTE);
                    Reset();
                }
            }
        }
    };

};

/*######
## npc_thrall_warchief
######*/

#define QUEST_6566              6566

#define SPELL_CHAIN_LIGHTNING   16033
#define SPELL_SHOCK             16034

#define GOSSIP_HTW "Please share your wisdom with me, Warchief."
#define GOSSIP_STW1 "What discoveries?"
#define GOSSIP_STW2 "Usurper?"
#define GOSSIP_STW3 "With all due respect, Warchief - why not allow them to be destroyed? Does this not strengthen our position?"
#define GOSSIP_STW4 "I... I did not think of it that way, Warchief."
#define GOSSIP_STW5 "I live only to serve, Warchief! My life is empty and meaningless without your guidance."
#define GOSSIP_STW6 "Of course, Warchief!"

//TODO: verify abilities/timers
class npc_thrall_warchief : public CreatureScript
{
public:
    npc_thrall_warchief() : CreatureScript("npc_thrall_warchief") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(5733, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
                player->SEND_GOSSIP_MENU(5734, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                player->SEND_GOSSIP_MENU(5735, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(5736, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
                player->SEND_GOSSIP_MENU(5737, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_STW6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
                player->SEND_GOSSIP_MENU(5738, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(QUEST_6566);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_6566) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HTW, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_thrall_warchiefAI (creature);
    }

    struct npc_thrall_warchiefAI : public ScriptedAI
    {
        npc_thrall_warchiefAI(Creature* c) : ScriptedAI(c) {}

        uint32 ChainLightning_Timer;
        uint32 Shock_Timer;

        void Reset()
        {
            ChainLightning_Timer = 2000;
            Shock_Timer = 8000;
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (ChainLightning_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_CHAIN_LIGHTNING);
                ChainLightning_Timer = 9000;
            } else ChainLightning_Timer -= diff;

            if (Shock_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_SHOCK);
                Shock_Timer = 15000;
            } else Shock_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

};

//RI - Amor en el Aire, suministrador de bolsas -quest


class npc_suministro_amoraire : public CreatureScript
{
public:
    npc_suministro_amoraire() : CreatureScript("npc_suministro_amoraire") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_suministro_amoraireAI (creature);
    }

    struct npc_suministro_amoraireAI : public ScriptedAI
    {
        npc_suministro_amoraireAI(Creature* c) : ScriptedAI(c) {}

        bool DarRegalo;
		uint32 RepPro;


        void Reset()
        {
            DarRegalo = false;
        }

void MoveInLineOfSight(Unit* who)
        {
			//Si el target a X metros:
     //                     Tiene el Aura 71450         Está a mínimo 10 yardas      No tiene el aura 71459
            if (!DarRegalo && me->IsWithinDistInMap(who, 10.0f) && who->GetAura(71450) && !who->GetAura(71459))
            {
				// Castear spell correspondiente -- Visual de un regalo en la espalda
                DoCast(who, 71459, true);
                 // Decir una frase que será la ID -1000010, en la tabla script_text de la DB
     	        DoScriptText(-1000010, me);     
				RepPro = 2000;
				DarRegalo = true;

            }
        }



        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
			if(DarRegalo)
			{
		
		if (RepPro <= diff)
           {
                DarRegalo = false;
				
            }
            else
                RepPro -= diff;

			}
		
		}

        
    };

};


class npc_recogesuministro : public CreatureScript
{
public:
    npc_recogesuministro() : CreatureScript("npc_recogesuministro") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_recogesuministroAI (creature);
    }

    struct npc_recogesuministroAI : public ScriptedAI
    {
        npc_recogesuministroAI(Creature* c) : ScriptedAI(c) {}

        
		


        void Reset()
        {
           
        }

void MoveInLineOfSight(Unit* who)
        {
			
   if (me->IsWithinDistInMap(who, 10.0f) && who->GetAura(71450) && who->GetAura(71459))
            {
				
                me->CastSpell(who, 71539, true);
				me->CastSpell(who, 71522, true);

				who->RemoveAurasDueToSpell(71450);

            }
        }



        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {}

        
    };

};

// Quest - Pisándole los talones - Evento Amor en el Aire

class npc_pisandole_los_talones : public CreatureScript
{
public:
    npc_pisandole_los_talones() : CreatureScript("npc_pisandole_los_talones") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pisandole_los_talonesAI (creature);
    }

    struct npc_pisandole_los_talonesAI : public ScriptedAI
    {
        npc_pisandole_los_talonesAI(Creature* c) : ScriptedAI(c) {}

        
		bool Cooldown;
		bool Ventormenta;
		bool Orgrimmar;
		bool Banco;
		bool Subastas;
		bool Peluqueria;
		uint64 PlayerGuid;
		bool KillCredit;
		uint32 Phase;
		uint32 uiPhaseTimer;
		uint64 GoblinGUID;


        void Reset()
        {
           Cooldown = false;
		   Ventormenta = false;
	       Orgrimmar = false;
		   Banco = false;
		   Subastas = false;
		   Peluqueria = false;
		   PlayerGuid = 0;
		   KillCredit = false;
		   Phase = 1;
		   GoblinGUID = 0;
		   uiPhaseTimer = 2000;
        }

void MoveInLineOfSight(Unit* who)
        {
			
   if (!Cooldown && who && who->ToPlayer() && me->IsWithinDistInMap(who, 5.0f) && who->GetTypeId() == TYPEID_PLAYER && (who->ToPlayer()->GetQuestStatus(24849) == QUEST_STATUS_INCOMPLETE || who->ToPlayer()->GetQuestStatus(24851) == QUEST_STATUS_INCOMPLETE) )
            {
				 if (me->GetZoneId() == 1637) //Orgrimmar
				 {
					if (me->GetEntry() == 90010) //Banco
					{
					//PlayerGuid = who->GetGUID();
					Phase = 1;
		            GoblinGUID = 0;
		            uiPhaseTimer = 2000;

				    Orgrimmar = true;
				    Ventormenta = false;
					Banco = true;
					Subastas = false;
		            Peluqueria = false;
					Cooldown = true;

					}
					if (me->GetEntry() == 90011) //Subastas
					{
					Phase = 1;
		            GoblinGUID = 0;
		            uiPhaseTimer = 2000;

					Orgrimmar = true;
					Ventormenta = false;
					Subastas = true;
					Peluqueria = false;
					Banco = false;
					Cooldown = true;
					}
					if (me->GetEntry() == 90012) //Peluquería
					{
                    Phase = 1;
		            GoblinGUID = 0;
		            uiPhaseTimer = 2000;

					Orgrimmar = true;
					Ventormenta = false;
					Subastas = false;
					Peluqueria = true;
					Banco = false;
					Cooldown = true;
					}

				 }


			    if (me->GetZoneId() == 1519) //Ventormenta
				{
					if (me->GetEntry() == 90010) //Banco
					{
					Phase = 1;
		           // GoblinGUID = 0;
		            uiPhaseTimer = 2000;

				    Orgrimmar = false;
				    Ventormenta = true;
					Banco = true;
					
					Subastas = false;
		            Peluqueria = false;
					Cooldown = true;
					}
					if (me->GetEntry() == 90011) //Subastas
					{
					Phase = 1;
		            GoblinGUID = 0;
		            uiPhaseTimer = 2000;

					Orgrimmar = false;
					Ventormenta = true;
					Subastas = true;
					Peluqueria = false;
					Banco = false;
					Cooldown = true;
					}
					if (me->GetEntry() == 90012) //Peluquería
					{
					Phase = 1;
		            GoblinGUID = 0;
		            uiPhaseTimer = 2000;

					Orgrimmar = false;
					Ventormenta = true;
					Subastas = false;
					Peluqueria = true;
					Banco = false;
					Cooldown = true;
					}

				}


            }

  if (KillCredit && who && who->ToPlayer() && me->IsWithinDistInMap(who, 5.0f) && who->GetTypeId() == TYPEID_PLAYER && (who->ToPlayer()->GetQuestStatus(24849) == QUEST_STATUS_INCOMPLETE || who->ToPlayer()->GetQuestStatus(24851) == QUEST_STATUS_INCOMPLETE) )
 {
	 if (me->GetEntry() == 90010)
	 who->ToPlayer()->KilledMonsterCredit(38340, 0);
	
	 if (me->GetEntry() == 90011)
	 who->ToPlayer()->KilledMonsterCredit(38341, 0);

	 if (me->GetEntry() == 90012)
	 who->ToPlayer()->KilledMonsterCredit(38342, 0);
 
 }


        }



        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
		
		if(Cooldown && (Orgrimmar || Ventormenta) && Banco)
		{
		     if (uiPhaseTimer <= diff)
            {
                switch (Phase)
                {
                    case 1:
						if(Orgrimmar)
						{
                if (Creature* goblin = me->SummonCreature(38334, 1626.07f, -4376.71f, 12.0f, 0.4814f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						if(Ventormenta)
						{
                if (Creature* goblin = me->SummonCreature(38334, -8931.47f, 615.215f, 99.522f, 3.6493f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						
						uiPhaseTimer = 3000;
                        Phase = 2;
                        break;
                    case 2:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000011, goblin);
					   }

                        uiPhaseTimer = 8000;
                        Phase = 3;
                        break;
                    case 3:
                         if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
						goblin->GetMotionMaster()->MovePoint(0, 1620.88f, -4378.89f, 12.2339f);
						   if(Ventormenta)
					    goblin->GetMotionMaster()->MovePoint(0, -8931.34f, 623.656f, 99.522f);


						 }
                        uiPhaseTimer = 2500;
                        Phase = 4;
                    case 5:
                         if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000012, goblin);
					   }

                        uiPhaseTimer = 6000;
                        Phase = 6;
                        break;
                    case 6:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000013, goblin);
					   }
                        uiPhaseTimer = 7500;
                        Phase = 7;
                        break;
                    case 7:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000014, goblin);
					   }
                        uiPhaseTimer = 9000;
                        Phase = 8;
                        break;
                    case 8:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000015, goblin);
					   }
						 uiPhaseTimer = 5000;
                        Phase = 9;
                        break;
				     case 9:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
                         goblin->GetMotionMaster()->MovePoint(0, 1614.55f, -4380.444f, 12.423f);
						   if(Ventormenta)
					     goblin->GetMotionMaster()->MovePoint(0, -8921.745f, 630.912f, 99.5228f);

					   }
						 uiPhaseTimer = 3000;
                        Phase = 10;
                        break;
				     case 10:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         goblin->DespawnOrUnsummon();
					   }
						 uiPhaseTimer = 2000;
                        Phase = 11;
                        break;
				     case 11:
                         KillCredit = true;
						 uiPhaseTimer = 4000;
                        Phase = 12;
                        break;
				  case 12:
                         KillCredit = false;
                        uiPhaseTimer = 15000;
                        Phase = 13;
                        break;
                  case 13:
                     Cooldown = false;
		             Ventormenta = false;
	                 Orgrimmar = false;
		             Banco = false;
		             Subastas = false;
		             Peluqueria = false;
		 
		 
                        uiPhaseTimer = 7000;
                        Phase = 13;
                        break;
                }
            } else uiPhaseTimer -= diff;
		
		
		}





		if(Cooldown && (Orgrimmar || Ventormenta) && Subastas)
		{
		     if (uiPhaseTimer <= diff)
            {
                switch (Phase)
                {
                    case 1:
						if(Orgrimmar)
						{
                if (Creature* goblin = me->SummonCreature(38334, 1685.536f, -4460.818f, 19.067f, 4.9935f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						if(Ventormenta)
						{
                if (Creature* goblin = me->SummonCreature(38334, -8814.67f, 662.07f, 95.423f, 4.9727f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						
						uiPhaseTimer = 3000;
                        Phase = 2;
                        break;
                    case 2:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000016, goblin);
					   }

                        uiPhaseTimer = 5000;
                        Phase = 3;
                        break;
                    case 3:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000017, goblin);
					   }
                        uiPhaseTimer = 5000;
                        Phase = 4;
                    case 5:
                         if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000018, goblin);
					   }

                        uiPhaseTimer = 10000;
                        Phase = 6;
                        break;
                    case 6:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000019, goblin);
					   }
                        uiPhaseTimer = 9000;
                        Phase = 7;
                        break;
                    case 7:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000020, goblin);
					   }
                        uiPhaseTimer = 10000;
                        Phase = 8;
                        break;
                    case 8:
             if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
                         goblin->GetMotionMaster()->MovePoint(0, 1683.89f, -4457.723f, 19.125f);
						   if(Ventormenta)
					     goblin->GetMotionMaster()->MovePoint(0, -8814.65f, 664.122f, 95.423f);

					   }
						 uiPhaseTimer = 3000;
                        Phase = 9;
                        break;
				     case 9:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000021, goblin);
					   }
						 uiPhaseTimer = 3000;
                        Phase = 10;
                        break;
				     case 10:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000022, goblin);
					   }
						 uiPhaseTimer = 6500;
                        Phase = 11;
                        break;
				     case 11:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
                         goblin->GetMotionMaster()->MovePoint(0, 1672.01f, -4437.669f, 19.356f);
						   if(Ventormenta)
					     goblin->GetMotionMaster()->MovePoint(0, -8810.165f, 666.373f, 95.423f);

					   }
						 uiPhaseTimer = 4000;
                        Phase = 12;
                        break;
				  case 12:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         goblin->DespawnOrUnsummon();
					   }
                        uiPhaseTimer = 2000;
                        Phase = 13;
                        break;
                  case 13:
                        KillCredit = true;
		 
                        uiPhaseTimer = 6000;
                        Phase = 14;
                        break;
			 case 14:
                        KillCredit = false;
		 
                        uiPhaseTimer = 14000;
                        Phase = 15;
                        break;
			 case 15:
                     Cooldown = false;
		             Ventormenta = false;
	                 Orgrimmar = false;
		             Banco = false;
		             Subastas = false;
		             Peluqueria = false;
		 
		 
                        uiPhaseTimer = 7000;
                        Phase = 15;
                        break;
                }
            } else uiPhaseTimer -= diff;
		
		
		}





if(Cooldown && (Orgrimmar || Ventormenta) && Peluqueria)
		{
		     if (uiPhaseTimer <= diff)
            {
                switch (Phase)
                {
                    case 1:
						if(Orgrimmar)
						{
                if (Creature* goblin = me->SummonCreature(38334, 1775.2f, -4341.105f, -7.508f, 4.1334f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						if(Ventormenta)
						{
                if (Creature* goblin = me->SummonCreature(38334, -8745.74f, 658.064f, 105.091f, 6.0918f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 200000))
                        GoblinGUID = goblin->GetGUID();
						}
						
						uiPhaseTimer = 3000;
                        Phase = 2;
                        break;
                    case 2:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000023, goblin);
					   }

                        uiPhaseTimer = 7800;
                        Phase = 3;
                        break;
                    case 3:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000024, goblin);
					   }
                        uiPhaseTimer = 8500;
                        Phase = 4;
						break;
                    case 4:
                         if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000025, goblin);
					   }

                        uiPhaseTimer = 14000;
                        Phase = 6;
                        break;
                    case 6:
                     if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
                         goblin->GetMotionMaster()->MovePoint(0, 1776.81f, -4339.751f, -7.421f);
						   if(Ventormenta)
					     goblin->GetMotionMaster()->MovePoint(0, -8748.468f, 657.575f, 105.0917f);
					 }
                        uiPhaseTimer = 2000;
                        Phase = 7;
                        break;
                    case 7:
                        if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000026, goblin);
					   }
                        uiPhaseTimer = 9000;
                        Phase = 8;
                        break;
				 case 8:
            if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         DoScriptText(-1000027, goblin);
					   }
						 uiPhaseTimer = 7000;
                        Phase = 9;
                        break;
				     case 9:
                       if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
						   if(Orgrimmar)
                         goblin->GetMotionMaster()->MovePoint(0, 1787.69f, -4331.43f, -9.444f);
						   if(Ventormenta)
					     goblin->GetMotionMaster()->MovePoint(0, -8756.73f, 657.546f, 105.0917f);

					   }
						 uiPhaseTimer = 5000;
                        Phase = 10;
                        break;
				     case 10:
                  if (Creature* goblin = Unit::GetCreature(*me, GoblinGUID))
					   {
                         goblin->DespawnOrUnsummon();
					   }
						 uiPhaseTimer = 2000;
                        Phase = 11;
                        break;
				     case 11:
                       KillCredit = true;
						 uiPhaseTimer = 5000;
                        Phase = 12;
                        break;
				  case 12:
                      KillCredit = false;

                        uiPhaseTimer = 10000;
                        Phase = 13;
                        break;
                  case 13:
                       Cooldown = false;
		             Ventormenta = false;
	                 Orgrimmar = false;
		             Banco = false;
		             Subastas = false;
		             Peluqueria = false;
		 
                        uiPhaseTimer = 7000;
                        Phase = 13;
                        break;
			
                }
            } else uiPhaseTimer -= diff;
		
		
		}




		}
    };

};

enum text
{
    TEXT_ID_A        = 20000,
    TEXT_ID_B        = 20001,
    TEXT_ID_C        = 20002,
    TEXT_ID_D        = 20003
};

#define GOSSIP_TEXT1  "Tengo por aqu""\xC3\xAD"" un cohete que lleva t""\xC3\xBA"" firma."
#define GOSSIP_TEXT2  "Hay como una especie de producto qu""\xC3\xAD""mico dentro... ""\xc2\xbf""Qu""\xC3\xA9"" es?"
#define GOSSIP_TEXT3  """\xc2\xbf""D""\xC3\xB3""nde se entregaron?"
#define GOSSIP_TEXT4  "<Recoger libro de contabilidad>"

// Evento Amor en el Aire - Quest: Una charla amistosa

class npc_misiloxido_q : public CreatureScript
{
public:
    npc_misiloxido_q() : CreatureScript("npc_misiloxido_q") { }

 
	bool OnGossipHello(Player* player, Creature* creature)
        { 
           if ( !player->HasItemCount(49915, 1) && (player->GetQuestStatus(24576) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(24657) == QUEST_STATUS_INCOMPLETE))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TEXT1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
       
            }

            player->SEND_GOSSIP_MENU(TEXT_ID_A, creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();
            bool roll = urand(0, 1);

            switch(action)
            {
                case GOSSIP_ACTION_INFO_DEF + 1: 
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TEXT2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
					player->SEND_GOSSIP_MENU(TEXT_ID_B, creature->GetGUID());
                    break;
                case GOSSIP_ACTION_INFO_DEF + 2: 
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TEXT3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
					player->SEND_GOSSIP_MENU(TEXT_ID_C, creature->GetGUID());
                    break;
                case GOSSIP_ACTION_INFO_DEF + 3: 
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TEXT4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
					player->SEND_GOSSIP_MENU(TEXT_ID_D, creature->GetGUID());
                    break;
                case GOSSIP_ACTION_INFO_DEF + 4: 
                    player->CLOSE_GOSSIP_MENU();
                    player->CastSpell(player, 70646, true);
                    break;
                
            }
            return true;
        }


};

void AddSC_orgrimmar()
{
    new npc_shenthul();
    new npc_thrall_warchief();
	new npc_suministro_amoraire();
	new npc_recogesuministro();
	new npc_pisandole_los_talones();
	new npc_misiloxido_q();
}
