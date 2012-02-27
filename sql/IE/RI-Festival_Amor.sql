# Modificando variable antigua del festival
UPDATE game_event SET holiday = '423', length='20160' WHERE eventEntry='8';
UPDATE achievement_criteria_data SET value1 = '423' WHERE value1='335';

#Añadiendo Scripts a los guardias de Orgrimmar y Ventormenta
UPDATE creature_template SET ScriptName = ' ', AIName = 'SmartAI' WHERE entry IN (68,3296);
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('68','0','0','0','1','0','10','1','10000','10000','60000','180000','11','71507','2','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Ventormenta - Colocar Perfume - Amor en el Aire');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('68','0','1','0','8','0','100','1','70192','0','2000','5000','28','71507','0','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Ventormenta - Retirar Aura');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('68','0','2','0','25','0','25','1','0','0','0','0','11','71342','2','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Ventormenta - Casteo de Cohete del Amor');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('3296','0','0','0','1','0','10','1','10000','10000','60000','180000','11','71507','2','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Orgrimmar - Colocar  Perfume - Amor en el Aire');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('3296','0','1','0','8','0','100','1','70192','0','2000','5000','28','71507','0','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Orgrimmar - Retirar aura');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('3296','0','2','0','25','0','25','1','0','0','0','0','11','71342','2','0','0','0','0','1','0','0','0','0','0','0','0','Guardia de Orgrimmar - Casteo de Cohete del amor');

#Añade el morph de un goblin al tener el aura de mensajero
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('71450','34850','2','Vestido de mensajero');
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('-71450','-71459','0','Remover caja cuando se vaya el disfra');
UPDATE quest_template SET SourceSpellId = '71450' WHERE id IN (24541,24656);
UPDATE creature_template SET minlevel = '75', maxlevel = '80', ScriptName='npc_suministro_amoraire' WHERE entry in (37671);
UPDATE creature_template SET ScriptName='npc_recogesuministro' WHERE entry in (37172,38066);

# A un paso - Quest
insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('90010','0','0','0','0','0','16925','0','0','0','Trigger - Banco',NULL,NULL,'0','80','80','0','35','35','0','1','1.14286','1','0','0','0','0','0','1','0','0','0','33554434','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_pisandole_los_talones','1');
insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('90011','0','0','0','0','0','16925','0','0','0','Trigger - Subastas',NULL,NULL,'0','80','80','0','35','35','0','1','1.14286','1','0','0','0','0','0','1','0','0','0','33554434','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_pisandole_los_talones','1');
insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('90012','0','0','0','0','0','16925','0','0','0','Trigger - Peluqueria',NULL,NULL,'0','80','80','0','35','35','0','1','1.14286','1','0','0','0','0','0','1','0','0','0','33554434','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_pisandole_los_talones','1');
UPDATE creature_template SET npcflag='1', ScriptName='npc_misiloxido_q' WHERE entry in (37715);

# Flirtear con el desastre
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=12846 AND `type` IN (16,18);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=12859 AND `type` IN (5,15,18);
INSERT INTO `achievement_criteria_data`(`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES 
(12846,16,335,0, ''),
(12859,5,26682,0, ''),
(12859,15,3,0, '');

#Cesta
UPDATE `gameobject_template` SET `data10`=45123 WHERE `entry`=187267;
UPDATE quest_template SET PrevQuestId='24805' WHERE id IN (24536);
UPDATE quest_template SET PrevQuestId='24536' WHERE id IN (24541);
UPDATE quest_template SET PrevQuestId='24851' WHERE id IN (24576);
UPDATE quest_template SET PrevQuestId='24541' WHERE id IN (24850);
UPDATE quest_template SET PrevQuestId='24850' WHERE id IN (24851);
UPDATE quest_template SET PrevQuestId='24655' WHERE id IN (24804);
UPDATE quest_template SET PrevQuestId='24656' WHERE id IN (24655);
UPDATE quest_template SET PrevQuestId='24848' WHERE id IN (24656);
UPDATE quest_template SET PrevQuestId='24849' WHERE id IN (24848);
UPDATE quest_template SET PrevQuestId='24657' WHERE id IN (24849);


#boticarios
UPDATE achievement_criteria_data SET TYPE='11' WHERE criteria_id IN (12992);
UPDATE `creature_template` SET  `Health_mod` = 86.189, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_apothecary_hummel' WHERE `entry` = 36296;
UPDATE `creature_template` SET  `Health_mod` = 86.189, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_apothecary_baxter' WHERE `entry` = 36565;
UPDATE `creature_template` SET  `Health_mod` = 86.189, `equipment_id` = 128, `mechanic_immune_mask` = 536870917, `flags_extra` = 256, `ScriptName` = 'npc_apothecary_frye' WHERE `entry` = 36272;
 
DELETE FROM `creature_loot_template` WHERE entry = 36296;
INSERT INTO `creature_loot_template` VALUES
(36296, 51808, 0, 1, 1, 1, 1),
(36296, 51805, 0, 1, 1, 1, 1),
(36296, 51804, 0, 1, 1, 1, 1),
(36296, 51806, 0, 1, 1, 1, 1),
(36296, 51807, 0, 1, 1, 1, 1),
(36296, 1, 10, 1, 1, -36296, 1),
(36296, 50250, 0.5, 0, 1, 1, 1);
 
DELETE FROM `reference_loot_template` WHERE entry = 36296;
INSERT INTO `reference_loot_template` VALUES
(36296, 50471, 0, 1, 1, 1, 1),
(36296, 50741, 0, 1, 1, 1, 1),
(36296, 49715, 0, 1, 1, 1, 1),
(36296, 50446, 0, 1, 1, 1, 1);

UPDATE `quest_template` SET `SpecialFlags`=9 WHERE `Id`=25485;

DELETE FROM `item_template` WHERE `entry`=54537;

INSERT INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `Duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `WDBVerified`) VALUES

(54537,15,0,-1,'Heart-Shaped Box',40293,3,4,0,1,0,0,0,-1,-1,80,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,1,'',0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,'',0,0,0,0,12340);

DELETE FROM `item_loot_template` WHERE `entry`=54537;

INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(54537,49715,0,1,1,1,1),
(54537,50446,0,1,1,1,1),
(54537,50741,0,1,1,1,1),
(54537,50471,6,1,0,1,1),
(54537,40753,100,1,0,2,2),
(54537,50250,1,1,0,1,1);


UPDATE creature_template SET ScriptName="npc_crazed_apothecary" WHERE entry=36568;


- Apothecary trio
DELETE FROM `creature` WHERE `id`IN (36296, 36565, 36272);

INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(650000, 36296, 33, 1, 1, 0, 0, -207.728, 2216.46, 79.7624, 5.01826, 604800, 0, 0, 269620, 0, 0, 0, 0, 0, 0),
(650001, 36565, 33, 1, 1, 0, 0, -209.865, 2213.18, 79.763, 5.01826, 604800, 0, 0, 269620, 0, 0, 0, 0, 0, 0),
(650002, 36272, 33, 1, 1, 0, 0, -204.071, 2215.01, 79.763, 5.01826, 604800, 0, 0, 269620, 0, 0, 0, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid`IN (140000, 140001, 140002);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES
(650000, 8),
(650001, 8),
(650002, 8);

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `Health_mod` = 86.189, `lootid` = 36296, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_apothecary_hummel' WHERE `entry` = 36296;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `Health_mod` = 86.189, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_apothecary_baxter' WHERE `entry` = 36565;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `Health_mod` = 86.189, `equipment_id` = 128, `mechanic_immune_mask` = 536870917, `flags_extra` = 256, `ScriptName` = 'npc_apothecary_frye' WHERE `entry` = 36272;

DELETE FROM `creature_loot_template` WHERE entry = 36296;
INSERT INTO `creature_loot_template` VALUES 
(36296, 51808, 0, 1, 1, 1, 1),
(36296, 51805, 0, 1, 1, 1, 1),
(36296, 51804, 0, 1, 1, 1, 1),
(36296, 51806, 0, 1, 1, 1, 1),
(36296, 51807, 0, 1, 1, 1, 1),
(36296, 1, 10, 1, 1, -36296, 1),
(36296, 50250, 0.5, 0, 1, 1, 1);

DELETE FROM `reference_loot_template` WHERE entry = 36296;
INSERT INTO `reference_loot_template` VALUES 
(36296, 50471, 0, 1, 1, 1, 1),
(36296, 50741, 0, 1, 1, 1, 1),
(36296, 49715, 0, 1, 1, 1, 1),
(36296, 50446, 0, 1, 1, 1, 1);

insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033020','No nos importa que lo hayáis descubierto... ya es demasiado tarde...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033021','Simplemente tenéis que morir y así mantener la boca cerrada...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033022','Os intoxicaréis con nuestro aroma.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033023','¡Vamos Baxter! ¡Acaba con estos intrusos!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033024','¡Frye, disuélvelos a todos!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033025','¡Destruirlos! ¡Machacarlos!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1033026','Este aroma... es el... aroma de la muerte...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0',NULL);
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('68529','-68530','0','Amor en el Aire -Colonias');
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('68530','-68529','0','Amor en el Aire - Colonias');

