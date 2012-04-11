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
#include "oculus.h"

#define GOSSIP_ITEM_DRAKES         "Entonces... ""\xc2\xbf""A d""\xC3\xB3""nde vamos?"
#define GOSSIP_ITEM_BELGARISTRASZ1 "Quiero luchar junto a un Draco Ruby"
#define GOSSIP_ITEM_BELGARISTRASZ2 """\xc2\xbf""Qu""\xC3\xA9"" habilidad tienen los Dracos Ruby?"
#define GOSSIP_ITEM_VERDISA1       "Quiero volar junto a un Draco Esmeralda"
#define GOSSIP_ITEM_VERDISA2       """\xc2\xbf""Qu""\xC3\xA9"" habilidad tienen los Dracos Esmeralda?"
#define GOSSIP_ITEM_ETERNOS1       "Quiero luchar junto a un Draco Ambar"
#define GOSSIP_ITEM_ETERNOS2       """\xc2\xbf""Qu""\xC3\xA9"" habilidad tienen los Dracos Ambar?"

#define HAS_ESSENCE(a) ((a)->HasItemCount(ITEM_EMERALD_ESSENCE, 1) || (a)->HasItemCount(ITEM_AMBER_ESSENCE, 1) || (a)->HasItemCount(ITEM_RUBY_ESSENCE, 1))

enum Drakes
{
    GOSSIP_TEXTID_DRAKES                          = 13267,
    GOSSIP_TEXTID_BELGARISTRASZ1                  = 12916,
    GOSSIP_TEXTID_BELGARISTRASZ2                  = 13466,
    GOSSIP_TEXTID_BELGARISTRASZ3                  = 13254,
    GOSSIP_TEXTID_VERDISA1                        = 1,
    GOSSIP_TEXTID_VERDISA2                        = 1,
    GOSSIP_TEXTID_VERDISA3                        = 13258,
    GOSSIP_TEXTID_ETERNOS1                        = 1,
    GOSSIP_TEXTID_ETERNOS2                        = 1,
    GOSSIP_TEXTID_ETERNOS3                        = 13256,

    ITEM_EMERALD_ESSENCE                          = 37815,
    ITEM_AMBER_ESSENCE                            = 37859,
    ITEM_RUBY_ESSENCE                             = 37860,

    NPC_VERDISA                                   = 27657,
    NPC_BELGARISTRASZ                             = 27658,
    NPC_ETERNOS                                   = 27659,

    SPELL_SHOCK_CHARGE                            = 49836,
    SPELL_MARTYR                                  = 50253
};

enum Says
{
    SAY_VAROS          = 0,
    SAY_UROM           = 1
};

class npc_oculus_drake : public CreatureScript
{
    public:
        npc_oculus_drake() : CreatureScript("npc_oculus_drake") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();
            switch (creature->GetEntry())

            {
                case NPC_VERDISA:
                    switch (action)
                    {
                        case GOSSIP_ACTION_INFO_DEF + 1:
                            if (!HAS_ESSENCE(player))
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA1, creature->GetGUID());
                            }
                            else
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA2, creature->GetGUID());
                            }
                            break;
                        case GOSSIP_ACTION_INFO_DEF + 2:
                        {
                            player->AddItem(ITEM_EMERALD_ESSENCE, 1);
                            player->CLOSE_GOSSIP_MENU();
                            break;
                        }
                        case GOSSIP_ACTION_INFO_DEF + 3:
                            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA3, creature->GetGUID());
                            break;
                    }
                    break;
                case NPC_BELGARISTRASZ:
                    switch (action)
                    {
                        case GOSSIP_ACTION_INFO_DEF + 1:
                            if (!HAS_ESSENCE(player))
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ1, creature->GetGUID());
                            }
                            else
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ2, creature->GetGUID());
                            }
                            break;
                        case GOSSIP_ACTION_INFO_DEF + 2:
                        {
                            player->AddItem(ITEM_RUBY_ESSENCE, 1);
                            player->CLOSE_GOSSIP_MENU();
                            break;
                        }
                        case GOSSIP_ACTION_INFO_DEF + 3:
                            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ3, creature->GetGUID());
                            break;
                    }
                    break;
                case NPC_ETERNOS:
                    switch (action)
                    {
                        case GOSSIP_ACTION_INFO_DEF + 1:
                            if (!HAS_ESSENCE(player))
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS1, creature->GetGUID());
                            }
                            else
                            {
                                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS2, creature->GetGUID());
                            }
                            break;
                        case GOSSIP_ACTION_INFO_DEF + 2:
                        {
                            player->AddItem(ITEM_AMBER_ESSENCE, 1);
                            player->CLOSE_GOSSIP_MENU();
                            break;
                        }
                        case GOSSIP_ACTION_INFO_DEF + 3:
                            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS3, creature->GetGUID());
                            break;
                    }
                    break;
            }

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->isQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (InstanceScript* instance = creature->GetInstanceScript())
            {
                if (instance->GetBossState(DATA_DRAKOS_EVENT) == DONE)
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DRAKES, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_DRAKES, creature->GetGUID());
                }
            }

            return true;
        }
};
class npc_oculus_mount : public CreatureScript
{
    public:
        npc_oculus_mount() : CreatureScript("npc_oculus_mount") { }

        struct npc_oculus_mountAI : public NullCreatureAI
        {
            npc_oculus_mountAI(Creature* c) : NullCreatureAI(c)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                _enterTimer = 1500;
                _entered = false;
            }


            void PassengerBoarded(Unit* /*unit*/, int8 /*seat*/, bool apply)

            {
                if (!apply)
                    me->DespawnOrUnsummon(1500);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!_entered)
                {
                    if (_enterTimer <= diff)
                    {
                        uint32 spellId = 0;
                        _entered = true;

                        switch (me->GetEntry())
                        {
                            case NPC_EMERALD_DRAKE:
                                spellId = 49346;
                                break;
                            case NPC_AMBER_DRAKE:
                                spellId = 49460;
                                break;
                            case NPC_RUBY_DRAKE:
                                spellId = 49464;
                                break;
                        }

                        if (!me->ToTempSummon())
                            return;

                        Unit* summoner = me->ToTempSummon()->GetSummoner();

                        if (summoner && summoner->isAlive() && summoner->GetDistance(me) < 30.0f && !summoner->isInCombat())
                        {
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            summoner->CastSpell(me, spellId, true);
							 
                        }
                        else
                            me->DespawnOrUnsummon();
                    }
                    else
                        _enterTimer -= diff;
             
				}
			
			
			
			
			
			
			}

        private:
            bool _entered;
            uint32 _enterTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_oculus_mountAI(creature);
        }
};

class spell_amber_drake_shock_lance : public SpellScriptLoader
{
    public:
        spell_amber_drake_shock_lance() : SpellScriptLoader("spell_amber_drake_shock_lance") { }

        class spell_amber_drake_shock_lance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_amber_drake_shock_lance_SpellScript);

            void RecalculateDamage()
            {
                if (Aura* charge = GetHitUnit()->GetAura(SPELL_SHOCK_CHARGE))
                {
                    SetHitDamage(6525 * charge->GetStackAmount() + GetHitDamage());
                    charge->Remove();
                }
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_amber_drake_shock_lance_SpellScript::RecalculateDamage);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_amber_drake_shock_lance_SpellScript();
        }
};

class IsNoValidDrake
{
    public:
        bool operator() (Unit* unit)
        {
            if (unit->ToCreature())

            {
                switch (unit->ToCreature()->GetEntry())
                {
                    case 27638: // Azure Ring Guardian
                    case 27656: // Ley-Guardian Eregos
                    case 28276: // Greater Ley-Whelp
                        return false;
                    default:
                        break;
                }
            }
            return true;
        }
};

class spell_amber_drake_stop_time : public SpellScriptLoader
{
    public:
        spell_amber_drake_stop_time() : SpellScriptLoader("spell_amber_drake_stop_time") { }

        class spell_amber_drake_stop_time_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_amber_drake_stop_time_SpellScript);

            void FilterTargets(std::list<Unit*>& unitList)
            {
                unitList.remove_if(IsNoValidDrake());
            }

            void HandleStun(SpellEffIndex /*effIndex*/)
            {
                if (GetHitUnit())
                    GetHitUnit()->CastCustomSpell(SPELL_SHOCK_CHARGE, SPELLVALUE_AURA_STACK, 5, GetHitUnit(), true);
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_amber_drake_stop_time_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_amber_drake_stop_time_SpellScript::HandleStun, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_amber_drake_stop_time_SpellScript();
        }
};

class spell_amber_drake_temporal_rift : public SpellScriptLoader
{
    public:
        spell_amber_drake_temporal_rift() : SpellScriptLoader("spell_amber_drake_temporal_rift") { }

        class spell_amber_drake_temporal_rift_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_amber_drake_temporal_rift_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget())
                    _targetHealth = GetTarget()->GetHealth();

                _damage = 0;
            }

            void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
            {
                _damage += _targetHealth - GetTarget()->GetHealth();

                for (; _damage >= 15000; _damage -= 15000)
                    GetTarget()->CastSpell(GetTarget(), SPELL_SHOCK_CHARGE, true);

                _targetHealth = GetTarget()->GetHealth();
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_amber_drake_temporal_rift_AuraScript::OnApply, EFFECT_2, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_amber_drake_temporal_rift_AuraScript::HandlePeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }

            uint32 _targetHealth;
            uint32 _damage;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_amber_drake_temporal_rift_AuraScript();
        }
};

class npc_image_belgaristrasz : public CreatureScript
{
public:
    npc_image_belgaristrasz() : CreatureScript("npc_image_belgaristrasz") { }

    struct npc_image_belgaristraszAI : public ScriptedAI
    {
        npc_image_belgaristraszAI(Creature* creature) : ScriptedAI(creature) {}

        void IsSummonedBy(Unit* summoner)
        {
            if (summoner->GetEntry() == NPC_VAROS)
            {
               Talk(SAY_VAROS);
               me->DespawnOrUnsummon(60000);
            }
            if (summoner->GetEntry() == NPC_UROM)
            {
               Talk(SAY_UROM);
               me->DespawnOrUnsummon(60000);
            }
        }            
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_image_belgaristraszAI(creature);
    }
};

void AddSC_oculus()
{
    new npc_oculus_drake();
    new npc_oculus_mount();
    new npc_image_belgaristrasz();
    new spell_amber_drake_shock_lance();
    new spell_amber_drake_stop_time();
    new spell_amber_drake_temporal_rift();
}
