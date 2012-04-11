-- (re) Add reference 26042
SET @NEC := 26042; -- Northrend Emotion Cooking Recipe Reference
DELETE FROM `reference_loot_template` WHERE `entry`=@NEC;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@NEC,43507,0,1,1,1,1), -- Recipe: Tasty cupcake
(@NEC,43508,0,1,1,1,1), -- Recipe: Last Week's Mammoth
(@NEC,43509,0,1,1,1,1), -- Recipe: Bad Clams
(@NEC,43510,0,1,1,1,1); -- Recipe: Haunted Herring

DELETE FROM `creature_loot_template` WHERE `entry` IN (2436,5928,5936,12239,12240,12241,12242,12243,14527,14529,14531,16506,16836,17307,21166,23809,23954,23963,23964,23983,24175,25234,28027,28113,28138,28494,29554,30177,30954,31779,40419);
UPDATE `creature_template`SET `lootid`=entry WHERE `entry` IN (2436,5928,5936,12239,12240,12241,12242,12243,14527,14529,14531,16506,16836,21166,23809,23963,23964,23983,25234,28027,28138,28494,29554,30954,31779,40419);
UPDATE `creature_template` SET `lootid`=0 WHERE `entry` IN (17307,23954,24175,28113,30177);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Farmer Kent (friendly?)
(2436,3692,-100,1,0,1,1), -- Hilsbrad Human Skull
-- Sorrow Wing
(5928,5808,-50,1,0,1,1), --  Pridewing Venom Sac
(5928,5137,80,1,0,1,1), -- Bright Eyeball
(5928,5136,10,1,0,1,1), -- Torn Furry Ear
(5928,1,100,1,0,-@NEC,1), -- Random world green drop ilvl 25-30
-- Orca
(5936,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(5936,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(5936,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(5936,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(5936,26005,1,1,1,-26005,1), -- Northrend World Green Reference #3
(5936,26006,1,1,1,-26006,1), -- Northrend World Green Reference #4
(5936,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(5936,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(5936,26019,0.5,1,1,-26019,1), -- Northrend World Blue Reference #3
(5936,26020,0.5,1,1,-26020,1), -- Northrend World Blue Reference #4
-- Add Theradric Crystal Carving (17684) to the following creatures
(12239,17684,-25,1,0,1,1), -- Spirit of Gelk
(12240,17684,-25,1,0,1,1), -- Spirit of Kolk
(12241,17684,-25,1,0,1,1), -- Spirit of Magra
(12242,17684,-25,1,0,1,1), -- Spirit of Maraudos
(12243,17684,-25,1,0,1,1), -- Spirit of Veng
(14527,18952,-100,1,0,1,1), -- Simone the Inconspicuous - Simone's Head
(14529,18953,-100,1,0,1,1), -- Franklin the Friendly - Klinfran's Head
(14531,18955,-100,1,0,1,1), -- Artorius the Amiable - Artorius's Head
(16506,22708,-100,1,0,1,1), -- Naxxramas Worshipper - Fate of Ramaladni
(16836,23460,-100,1,0,1,1), -- Escaped Dreghood - Broken Blood Sample
(21166,30451,-15,1,0,1,1), -- Illidari Dreadlord - Lohn'goron, Bow of the Torn-heart
-- Vengeance Landing Cannoneer
(23809,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23809,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23809,26005,1,1,1,-26005,1), -- Northrend World Green Reference #3
-- Sergeant Lorric
(23963,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23963,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23963,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23963,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23963,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23963,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23963,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- Lieutenant Celeyne
(23964,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23964,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23964,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23964,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23964,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23964,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23964,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- North Fleet Marine
(23983,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23983,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23983,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23983,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23983,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23983,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23983,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- Stormfleet Deckhand
(25234,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(25234,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
-- High-Oracle Soo-say
(28027,17058,50,1,0,1,1), -- Fish Oil
(28027,17057,30,1,0,1,1), -- Shiny Fish Scales
(28027,33470,15,1,0,2,4), -- Frostweave Cloth
(28027,35951,10,1,0,1,3), -- Poached Emperor Salmon
(28027,38642,-1,1,0,1,1), -- Golden Engagement Ring
-- Elder Harkek
(28138,33470,40,1,0,2,4), -- Frostweave Cloth
(28138,33447,4,1,0,1,1), -- Runic Healing Potion
(28138,38642,-1,1,0,1,1), -- Golden Engagement Ring
-- Kutube'sa
(28494,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(28494,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(28494,26010,1,1,1,-26010,1), -- Northrend World Green Reference #4
(28494,26011,1,1,1,-26011,1), -- Northrend World Green Reference #5
(28494,26012,1,1,1,-26012,1), -- Northrend World Green Reference #6
(28494,26023,0.5,1,1,-26023,1), -- Northrend World Blue Reference #3
(28494,26025,0.5,1,1,-26025,1), -- Northrend World Blue Reference #4
(28494,26026,0.5,1,1,-26026,1), -- Northrend World Blue Reference #5
(28494,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
(28494,39152,35,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(28494,43297,1,1,0,1,1), -- Damaged Necklace
-- Snowblind Devotee
(29554,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(29554,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(29554,26009,1,1,1,-26009,1), -- Northrend World Green Reference #3
(29554,26010,1,1,1,-26010,1), -- Northrend World Green Reference #4
(29554,26011,1,1,1,-26011,1), -- Northrend World Green Reference #5
(29554,26012,1,1,1,-26012,1), -- Northrend World Green Reference #6
(29554,26013,1,1,1,-26013,1), -- Northrend World Green Reference #7
(29554,26023,0.5,1,1,-26023,1), -- Northrend World Blue Reference #3
(29554,26024,0.5,1,1,-26024,1), -- Northrend World Blue Reference #4
(29554,26025,0.5,1,1,-26025,1), -- Northrend World Blue Reference #5
(29554,26026,0.5,1,1,-26026,1), -- Northrend World Blue Reference #6
(29554,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
(29554,39152,35,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(29554,43297,1,1,0,1,1), -- Damaged Necklace
-- Rokir
(30954,26001,6,1,1,-26001,1), -- Northrend World Grey Reference #2
(30954,26002,6,1,1,-26002,1), -- Northrend World Grey Reference #3
(30954,26014,2,1,1,-26014,1), -- Northrend World Green Reference #8
(30954,26015,2,1,1,-26015,1), -- Northrend World Green Reference #9
-- Skeletal Archmage
(31779,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(31779,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(31779,26013,1,1,1,-26013,1), -- Northrend World Green Reference #7
(31779,26014,1,1,1,-26014,1), -- Northrend World Green Reference #8
(31779,26015,1,1,1,-26015,1), -- Northrend World Green Reference #9
(31779,26028,0.5,1,1,-26028,1), -- Northrend World Blue Reference #8
(31779,39152,50,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(31779,43297,1,1,0,1,1), -- Damaged Necklace
-- Charscale Assaulter
(40419,26001,6,1,1,-26001,1), -- Northrend World Grey Reference #2
(40419,26002,6,1,1,-26002,1), -- Northrend World Grey Reference #3
(40419,26015,2,1,1,-26015,1), -- Northrend World Green Reference #9
(40419,26016,2,1,1,-26016,1); -- Northrend World Green Reference #10
-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` IN (28494,29554,31779);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(1,28494,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390'),
(1,29554,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390'),
(1,31779,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390');
-- darkmoon faerie resync, again
UPDATE `game_event` SET `start_time`='2012-04-01 00:01:00' WHERE `eventEntry`=5;
UPDATE `game_event` SET `start_time`='2012-05-06 00:01:00' WHERE `eventEntry`=3;
UPDATE `game_event` SET `start_time`='2012-06-03 00:01:00' WHERE `eventEntry`=4;
UPDATE `creature_template` SET `HoverHeight`=10.8, `VehicleId`=232 WHERE `entry`=30393;
UPDATE `creature_template` SET `HoverHeight`=10.8, `VehicleId`=237 WHERE `entry`=30461;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=27530;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=26277;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=26276;
UPDATE `creature_template` SET `HoverHeight`=1.2 WHERE `entry`=31070;
UPDATE `creature_template` SET `HoverHeight`=12 WHERE `entry`=37126;
UPDATE `creature_template` SET `HoverHeight`=15 WHERE `entry`=27608;
UPDATE `creature_template` SET `HoverHeight`=15 WHERE `entry`=27608;
UPDATE `creature_template` SET `HoverHeight`=1.6 WHERE `entry`=38392;
UPDATE `creature_template` SET `HoverHeight`=2.25 WHERE `entry`=30272;
UPDATE `creature_template` SET `HoverHeight`=2.58, `Scale`=1.72 WHERE `entry`=26607;
UPDATE `creature_template` SET `HoverHeight`=25 WHERE `entry`=37755;
UPDATE `creature_template` SET `HoverHeight`=26 WHERE `entry`=29790;
UPDATE `creature_template` SET `HoverHeight`=2.7 WHERE `entry`=25451;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=29048;
UPDATE `creature_template` SET `HoverHeight`=2, `VehicleId`=234 WHERE `entry`=30228;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=25445;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=25721;
UPDATE `creature_template` SET `HoverHeight`=35 WHERE `entry`=27789;
UPDATE `creature_template` SET `HoverHeight`=3 WHERE `entry`=34567;
UPDATE `creature_template` SET `HoverHeight`=3 WHERE `entry`=26668;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=390 WHERE `entry`=34120;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=108 WHERE `entry`=24083;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=270 WHERE `entry`=31137;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=24272;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=37098;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=28534;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=28511;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=32534;
UPDATE `creature_template` SET `HoverHeight`=5, `VehicleId`=348 WHERE `entry`=33214;
UPDATE `creature_template` SET `HoverHeight`=5 WHERE `entry`=27693;
UPDATE `creature_template` SET `HoverHeight`=5 WHERE `entry`=34203;
UPDATE `creature_template` SET `HoverHeight`=6.25 WHERE `entry`=40083;
UPDATE `creature_template` SET `HoverHeight`=6.25 WHERE `entry`=40100;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34496;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34496;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34497;
UPDATE `creature_template` SET `HoverHeight`=7.5 WHERE `entry`=26933;
UPDATE `creature_template` SET `HoverHeight`=8.4, `VehicleId`=232 WHERE `entry`=30420;
UPDATE `creature_template` SET `HoverHeight`=8 WHERE `entry`=33186;
UPDATE `creature_template` SET `HoverHeight`=9 WHERE `entry`=26933;
UPDATE `creature_template` SET `HoverHeight`=9  WHERE `entry`=37528;
UPDATE `creature_template` SET `HoverHeight`=9  WHERE `entry`=37230;
UPDATE `creature_template` SET `HoverHeight`=9, `VehicleId`=375 WHERE `entry`=33687;
UPDATE `creature_template` SET `HoverHeight`=9, `VehicleId`=535 WHERE `entry`=36661;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10.8, `VehicleId`=232 WHERE `entry`=30393;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10 WHERE `entry`=27608;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10 WHERE `entry`=27608;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=15 WHERE `entry`=32630;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=1.6 WHERE `entry`=38391;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2.25, `VehicleId`=247 WHERE `entry`=30564;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2.25 WHERE `entry`=30272;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=25721;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=29570;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3.12, `Scale`=2.08 WHERE `entry`=26607;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3 WHERE `entry`=26668;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3, `VehicleId`=108 WHERE `entry`=24083;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=4 WHERE `entry`=37098;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=4  WHERE `entry`=30945;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5, `VehicleId`=276 WHERE `entry`=31432;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=6 WHERE `entry`=30501;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=7.5 WHERE `entry`=26933;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=8.4, `VehicleId`=232 WHERE `entry`=30420;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=9 WHERE `entry`=26933;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (34477, 35079);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(34477,'spell_hun_misdirection'), 
(35079,'spell_hun_misdirection_proc');
ALTER TABLE `battleground_template` CHANGE `Weight` `Weight` tinyint(3) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `conditions` CHANGE `SourceId` `SourceId` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `creature` CHANGE `equipment_id` `equipment_id` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `creature_addon` CHANGE `path_id` `path_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_ai_scripts` CHANGE `id` `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier';
ALTER TABLE `creature_ai_scripts` CHANGE `creature_id` `creature_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Template Identifier';
ALTER TABLE `creature_ai_scripts` CHANGE `event_type` `event_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type';
ALTER TABLE `creature_ai_scripts` CHANGE `event_chance` `event_chance` int(10) unsigned NOT NULL DEFAULT '100';
ALTER TABLE `creature_ai_scripts` CHANGE `event_flags` `event_flags` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_ai_scripts` CHANGE `action1_type` `action1_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_scripts` CHANGE `action2_type` `action2_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_scripts` CHANGE `action3_type` `action3_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_summons` CHANGE `id` `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Identifier';
ALTER TABLE `creature_ai_summons` CHANGE `spawntimesecs` `spawntimesecs` int(10) unsigned NOT NULL DEFAULT '120';
ALTER TABLE `creature_classlevelstats` CHANGE `level` `level` tinyint(4) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `class` `class` tinyint(4) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp0` `basehp0` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp1` `basehp1` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp2` `basehp2` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basemana` `basemana` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basearmor` `basearmor` smallint(6) NOT NULL;
ALTER TABLE `creature_formations` CHANGE `leaderGUID` `leaderGUID` int(10) unsigned NOT NULL;
ALTER TABLE `creature_formations` CHANGE `memberGUID` `memberGUID` int(10) unsigned NOT NULL;
ALTER TABLE `creature_formations` CHANGE `groupAI` `groupAI` int(10) unsigned NOT NULL;
ALTER TABLE `creature_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `creature_onkill_reputation` CHANGE `RewOnKillRepValue1` `RewOnKillRepValue1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `KillCredit1` `KillCredit1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `KillCredit2` `KillCredit2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `exp` `exp` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance1` `resistance1` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance2` `resistance2` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance3` `resistance3` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance4` `resistance4` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance5` `resistance5` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance6` `resistance6` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem1` `questItem1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem2` `questItem2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem3` `questItem3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem4` `questItem4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem5` `questItem5` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem6` `questItem6` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `creature_template_addon` CHANGE `path_id` `path_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_transport` CHANGE `guid` `guid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'GUID of NPC on transport - not the same as creature.guid';
ALTER TABLE `creature_transport` CHANGE `transport_entry` `transport_entry` int(11) NOT NULL COMMENT 'Transport entry';
ALTER TABLE `creature_transport` CHANGE `npc_entry` `npc_entry` int(11) NOT NULL COMMENT 'NPC entry';
ALTER TABLE `creature_transport` CHANGE `emote` `emote` int(11) NOT NULL;
ALTER TABLE `db_script_string` CHANGE `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';  
  ALTER TABLE `exploration_basexp` CHANGE `level` `level` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `exploration_basexp` CHANGE `basexp` `basexp` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `fishing_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `game_event_creature` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_gameobject` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_model_equip` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_npc_vendor` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_pool` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `gameobject_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `gameobject_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `gossip_menu` CHANGE `entry` `entry` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `menu_id` `menu_id` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `id` `id` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_money` `box_money` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_menu_id` `action_menu_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `instance_template` CHANGE `allowMount` `allowMount` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `ip2nation` CHANGE `ip` `ip` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `item_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `item_set_names` CHANGE `WDBVerified` `WDBVerified` smallint(6) NOT NULL DEFAULT '1';
ALTER TABLE `item_template` CHANGE `spellcharges_1` `spellcharges_1` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_2` `spellcharges_2` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_3` `spellcharges_3` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_4` `spellcharges_4` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_5` `spellcharges_5` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `BagFamily` `BagFamily` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `TotemCategory` `TotemCategory` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_1` `socketContent_1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_2` `socketContent_2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_3` `socketContent_3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketBonus` `socketBonus` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `GemProperties` `GemProperties` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `item_template` CHANGE `ScalingStatValue` `ScalingStatValue` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `mail_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `milling_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `npc_spellclick_spells` CHANGE `user_type` `user_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'relation with summoner: 0-no 1-friendly 2-raid 3-party player can click';
ALTER TABLE `outdoorpvp_template` CHANGE `TypeId` `TypeId` tinyint(3) unsigned NOT NULL;
ALTER TABLE `page_text` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `pet_name_generation` CHANGE `half` `half` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `pickpocketing_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `player_factionchange_achievement` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_achievement` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `race_A` `race_A` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `race_H` `race_H` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_reputations` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_reputations` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_spells` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_spells` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_xp_for_level` CHANGE `lvl` `lvl` tinyint(3) unsigned NOT NULL; -- also changed from int to tinyint
ALTER TABLE `playercreateinfo_action` CHANGE `action` `action` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `playercreateinfo_item` CHANGE `amount` `amount` tinyint(4) NOT NULL DEFAULT '1';
ALTER TABLE `playercreateinfo_spell_custom` DROP `Active`; -- delete field, it's not used anywhere
ALTER TABLE `prospecting_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `quest_poi` CHANGE `objIndex` `objIndex` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_poi_points` CHANGE `x` `x` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_poi_points` CHANGE `y` `y` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredFactionValue1` `RequiredFactionValue1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredFactionValue2` `RequiredFactionValue2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMinRepValue` `RequiredMinRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMinRepValue` `RequiredMinRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMaxRepValue` `RequiredMaxRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `PrevQuestId` `PrevQuestId` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `NextQuestId` `NextQuestId` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `ExclusiveGroup` `ExclusiveGroup` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardSpellCast` `RewardSpellCast` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardHonor` `RewardHonor` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardXPId` `RewardXPId` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId1` `RewardFactionValueId1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId2` `RewardFactionValueId2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId3` `RewardFactionValueId3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId4` `RewardFactionValueId4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId5` `RewardFactionValueId5` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride1` `RewardFactionValueIdOverride1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride2` `RewardFactionValueIdOverride2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride3` `RewardFactionValueIdOverride3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride4` `RewardFactionValueIdOverride4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride5` `RewardFactionValueIdOverride5` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo1` `RequiredNpcOrGo1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo2` `RequiredNpcOrGo2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo3` `RequiredNpcOrGo3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo4` `RequiredNpcOrGo4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `Unknown0` `Unknown0` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay1` `DetailsEmoteDelay1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay2` `DetailsEmoteDelay2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay3` `DetailsEmoteDelay3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay4` `DetailsEmoteDelay4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay1` `OfferRewardEmoteDelay1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay2` `OfferRewardEmoteDelay2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay3` `OfferRewardEmoteDelay3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay4` `OfferRewardEmoteDelay4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NOT NULL DEFAULT '1';
ALTER TABLE `reference_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `reputation_spillover_template` CHANGE `faction` `faction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction entry';
ALTER TABLE `reputation_spillover_template` CHANGE `faction1` `faction1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction to give spillover for';
ALTER TABLE `reputation_spillover_template` CHANGE `faction2` `faction2` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `reputation_spillover_template` CHANGE `faction3` `faction3` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `reputation_spillover_template` CHANGE `faction4` `faction4` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `skinning_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `spell_area` CHANGE `quest_start_active` `quest_start_active` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_area` CHANGE `gender` `gender` tinyint(3) unsigned NOT NULL DEFAULT '2';
ALTER TABLE `spell_area` CHANGE `autocast` `autocast` tinyint(3) unsigned NOT NULL DEFAULT '0';
-- All the fields in spell_dbc where changed to full int32 since the DBC structure is used
ALTER TABLE `spell_dbc` CHANGE `Dispel` `Dispel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Mechanic` `Mechanic` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `CastingTimeIndex` `CastingTimeIndex` int(10) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `spell_dbc` CHANGE `DurationIndex` `DurationIndex` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `ProcChance` `ProcChance` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `ProcCharges` `ProcCharges` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `BaseLevel` `BaseLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxLevel` `MaxLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `SpellLevel` `SpellLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `RangeIndex` `RangeIndex` int(10) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `spell_dbc` CHANGE `Effect1` `Effect1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Effect2` `Effect2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Effect3` `Effect3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic1` `EffectMechanic1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic2` `EffectMechanic2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic3` `EffectMechanic3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA1` `EffectImplicitTargetA1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA2` `EffectImplicitTargetA2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA3` `EffectImplicitTargetA3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB1` `EffectImplicitTargetB1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB2` `EffectImplicitTargetB2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB3` `EffectImplicitTargetB3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex1` `EffectRadiusIndex1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex2` `EffectRadiusIndex2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex3` `EffectRadiusIndex3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName1` `EffectApplyAuraName1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName2` `EffectApplyAuraName2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName3` `EffectApplyAuraName3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxTargetLevel` `MaxTargetLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `SpellFamilyName` `SpellFamilyName` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxAffectedTargets` `MaxAffectedTargets` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `DmgClass` `DmgClass` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `PreventionType` `PreventionType` int(10) unsigned NOT NULL DEFAULT '0';
--
ALTER TABLE `spell_group` CHANGE `id` `id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `spell_proc` CHANGE `spellPhaseMask` `spellPhaseMask` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `spell_proc` CHANGE `hitMask` `hitMask` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `spell_enchant_proc_data` CHANGE `procEx` `procEx` int(10) unsigned NOT NULL DEFAULT '0'; -- changed from float to int
ALTER TABLE `spell_required` CHANGE `spell_id` `spell_id` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `spell_required` CHANGE `req_spell` `req_spell` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `spell_threat` CHANGE `flatMod` `flatMod` int(11) NULL DEFAULT NULL;
ALTER TABLE `vehicle_accessory` CHANGE `seat_id` `seat_id` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_accessory` CHANGE `minion` `minion` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_template_accessory` CHANGE `seat_id` `seat_id` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_template_accessory` CHANGE `minion` `minion` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `version` CHANGE `cache_id` `cache_id` int(11) NULL DEFAULT '0';
ALTER TABLE `waypoint_data` CHANGE `move_flag` `move_flag` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `StackAmount` `StackAmount` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `waypoint_data` CHANGE `action_chance` `action_chance` smallint(6) NOT NULL DEFAULT '100';
ALTER TABLE `item_loot_template` CHANGE `maxcount` `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1';
-- Hunter Volley
UPDATE `spell_bonus_data` SET `ap_bonus`=0.0837 WHERE `entry`=42243;
-- revised from Unholys original works
-- quest 12702 chicken party!
-- quest 12532 flown the coop!
-- 
SET @ENTRY := 28161; -- the chicken
SET @PARTY := 12702; -- chicken party quest
SET @COOP := 12532; -- flown the coop quest
SET @LIFE := 900000; -- minutes

-- set up required spells for the spells to work as they should
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@ENTRY;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES 
(@ENTRY,39996,1,0), -- cover spell (dummy)
(@ENTRY,51037,2,0); -- creates item in players back pack

-- set npc up to use event script
UPDATE `creature_template` SET `AIName`='SmartAI'  WHERE `entry`=@ENTRY;

-- convert over to smart script
DELETE FROM `creature_ai_scripts` WHERE `id`=@ENTRY; -- delete old eai scripts
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,1000,2000,3000,89,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'create random movement every 2-3 secs'),
(@ENTRY,0,1,0,8,0,100,0,51951,0,0,0,11,50839,0,0,0,0,0,1,0,0,0,0,0,0,0, 'when hit with net cast self stun'),
(@ENTRY,0,2,0,8,0,100,0,39996,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'force despawn @1 sec when hit with dummy spell');

-- Remove previous scripts that may interfere with this work
DELETE FROM `quest_start_scripts` WHERE `id` IN (@PARTY,@COOP);

-- start script for quest chicken party (they do not all spawn at same time)
UPDATE `quest_template` SET `StartScript`=@PARTY WHERE `id`=@PARTY; -- 12072
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES 
(@PARTY,1,10,@ENTRY,@LIFE, 0,5251.09,4413.76,-96.086,4.8714),
(@PARTY,2,10,@ENTRY,@LIFE, 0,5251.22,4419.74,-95.8995,3.58335),
(@PARTY,23,10,@ENTRY,@LIFE, 0,5257.58,4421.77,-95.9072,2.62124),
(@PARTY,4,10,@ENTRY,@LIFE,0, 5255.97,4420.37,-95.9999,0.0451326),
(@PARTY,5,10,@ENTRY,@LIFE,0, 5256.78,4420.63,-95.9957,0.320021),
(@PARTY,6,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,0.956194),
(@PARTY,27,10,@ENTRY,@LIFE,0, 5258.54,4420.49,-96.0195,0.551714),
(@PARTY,8,10,@ENTRY,@LIFE,0, 5250.67,4417.98,-95.9787,4.39231),
(@PARTY,9,10,@ENTRY,@LIFE,0, 5273.53,4430.32,-96.0241,1.0897),
(@PARTY,40,10,@ENTRY,@LIFE,0, 5158.3,4605.25,-130.988,3.7522),
(@PARTY,21,10,@ENTRY,@LIFE,0, 5164.6,4609.43,-130.427,3.70115),
(@PARTY,22,10,@ENTRY,@LIFE,0, 5169.53,4612.44,-130.817,4.05065),
(@PARTY,23,10,@ENTRY,@LIFE,0, 5188.49,4627.85,-132.485,3.60691),
(@PARTY,44,10,@ENTRY,@LIFE,0, 5203.19,4631.63,-132.611,2.849),
(@PARTY,25,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.378917),
(@PARTY,26,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.66166),
(@PARTY,27,10,@ENTRY,@LIFE,0, 5203.5,4595.02,-111.327,5.51542),
(@PARTY,48,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,0.579192),
(@PARTY,29,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,1.09756),
(@PARTY,30,10,@ENTRY,@LIFE,0, 5172.43,4533.25,-97.3836,1.15253),
(@PARTY,41,10,@ENTRY,@LIFE,0, 5186.29,4522.69,-91.0957,3.02571),
(@PARTY,32,10,@ENTRY,@LIFE,0, 5214.67,4485.22,-91.3113,2.40524),
(@PARTY,33,10,@ENTRY,@LIFE,0, 5221.85,4475.99,-96.8801,4.89495),
(@PARTY,34,10,@ENTRY,@LIFE,0, 5222.95,4438.1,-96.8062,1.6277),
(@PARTY,35,10,@ENTRY,@LIFE,0, 5224.36,4427.83,-96.9221,2.63301),
(@PARTY,36,10,@ENTRY,@LIFE,0, 5234.72,4406.44,-95.2917,0.0647549),
(@PARTY,47,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,3.79933),
(@PARTY,38,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,4.29414),
(@PARTY,39,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,3.90536),
(@PARTY,40,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,4.36089);

-- start script for quest flown the coop (they do not all spawn at same time)
UPDATE `quest_template` SET `StartScript`=@COOP WHERE `id`=@COOP; -- 12532
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES 
(@COOP,23,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,2.62124),
(@COOP,4,10,@ENTRY,@LIFE,0, 5255.97,4420.37,-95.9999,0.0451326),
(@COOP,5,10,@ENTRY,@LIFE,0, 5256.78,4420.63,-95.9957,0.320021),
(@COOP,6,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,0.956194),
(@COOP,27,10,@ENTRY,@LIFE,0, 5258.54,4420.49,-96.0195,0.551714),
(@COOP,8,10,@ENTRY,@LIFE,0, 5250.67,4417.98,-95.9787,4.39231),
(@COOP,9,10,@ENTRY,@LIFE,0, 5273.53,4430.32,-96.0241,1.0897),
(@COOP,40,10,@ENTRY,@LIFE,0, 5158.3,4605.25,-130.988,3.7522),
(@COOP,21,10,@ENTRY,@LIFE,0, 5164.6,4609.43,-130.427,3.70115),
(@COOP,22,10,@ENTRY,@LIFE,0, 5169.53,4612.44,-130.817,4.05065),
(@COOP,23,10,@ENTRY,@LIFE,0, 5188.49,4627.85,-132.485,3.60691),
(@COOP,44,10,@ENTRY,@LIFE,0, 5203.19,4631.63,-132.611,2.849),
(@COOP,25,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.378917),
(@COOP,26,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.66166),
(@COOP,27,10,@ENTRY,@LIFE,0, 5203.5,4595.02,-111.327,5.51542),
(@COOP,48,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,0.579192),
(@COOP,29,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,1.09756),
(@COOP,30,10,@ENTRY,@LIFE,0, 5172.43,4533.25,-97.3836,1.15253),
(@COOP,41,10,@ENTRY,@LIFE,0, 5186.29,4522.69,-91.0957,3.02571),
(@COOP,32,10,@ENTRY,@LIFE,0, 5214.67,4485.22,-91.3113,2.40524),
(@COOP,33,10,@ENTRY,@LIFE,0, 5221.85,4475.99,-96.8801,4.89495),
(@COOP,34,10,@ENTRY,@LIFE,0, 5222.95,4438.1,-96.8062,1.6277),
(@COOP,35,10,@ENTRY,@LIFE,0, 5224.36,4427.83,-96.9221,2.63301),
(@COOP,36,10,@ENTRY,@LIFE,0, 5234.72,4406.44,-95.2917,0.0647549),
(@COOP,47,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,3.79933),
(@COOP,38,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,4.29414),
(@COOP,39,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,3.90536),
(@COOP,40,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,4.36089);

-- -------------------------------
-- -- The Antechamber of Ulduar --
-- -------------------------------
-- Creatures
SET @Brundir10 :=32857;
call `sp_get_npc_diffentry`(@Brundir10,1,@Brundir25); -- Get 25man id using procedure
SET @Molgeim10 :=32927;
call `sp_get_npc_diffentry`(@Molgeim10,1,@Molgeim25); -- Get 25man id using procedure
SET @Steelbreaker10 :=32867;
call `sp_get_npc_diffentry`(@Steelbreaker10,1,@Steelbreaker25); -- Get 25man id using procedure
SET @Auriaya10 :=33515;
call `sp_get_npc_diffentry`(@Auriaya10,1,@Auriaya25); -- Get 25man id using procedure
-- Gameobjects
SET @Kologarn10 := 195046; -- Cache of the Living Stone 10man
CALL `sp_get_go_lootid`(@Kologarn10,@CacheLivingStone10); -- Get Lootid from data1 field using procedure
SET @Kologarn25 := 195047; -- Cache of the Living Stone 25man
CALL `sp_get_go_lootid`(@Kologarn25,@CacheLivingStone25); -- Get Lootid from data1 field using procedure
-- bosses
SET @Assembly10Ref := 34359;
SET @Assembly25Ref := @Assembly10Ref+1;
SET @Kologarn10Ref := @Assembly10Ref+2;
SET @Kologarn25Ref := @Assembly10Ref+3;
SET @Auriaya10Ref := @Assembly10Ref+4;
SET @Auriaya25Ref := @Assembly10Ref+5;

-- ------------------------------
-- -- Reference Loot Templates --
-- ------------------------------
-- Delete previous templates if existing
DELETE FROM `reference_loot_template` WHERE `entry` IN (12019,34122,34123,34124,34163,34216);
-- Delete the current if existing & add
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @Assembly10Ref AND @Assembly10Ref+5;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Assembly Of Iron 10man
(@Assembly10Ref,45322,0,1,1,1,1), -- Cloak of the Iron Council
(@Assembly10Ref,45324,0,1,1,1,1), -- Leggings of Swift Reflexes
(@Assembly10Ref,45329,0,1,1,1,1), -- Circlet of True Sight
(@Assembly10Ref,45330,0,1,1,1,1), -- Greaves of Iron Intensity
(@Assembly10Ref,45331,0,1,1,1,1), -- Rune-Etched Nightblade
(@Assembly10Ref,45332,0,1,1,1,1), -- Stormtip
(@Assembly10Ref,45333,0,1,1,1,1), -- Belt of the Iron Servant
(@Assembly10Ref,45378,0,1,1,1,1), -- Boots of the Petrified Forest
(@Assembly10Ref,45418,0,1,1,1,1), -- Lady Maye's Sapphire Ring
(@Assembly10Ref,45423,0,1,1,1,1), -- Runetouch Wristwraps
-- Assembly Of Iron 25man
(@Assembly25Ref,45233,0,1,1,1,1), -- Stormrune Edge
(@Assembly25Ref,45234,0,1,1,1,1), -- Rapture
(@Assembly25Ref,45237,0,1,1,1,1), -- Phaelia's Vestments of the Sprouting Seed
(@Assembly25Ref,45193,0,1,1,1,1), -- Insurmountable Fervor
(@Assembly25Ref,45236,0,1,1,1,1), -- Unblinking Eye
(@Assembly25Ref,45225,0,1,1,1,1), -- Steelbreaker's Embrace
(@Assembly25Ref,45240,0,1,1,1,1), -- Raiments of the Iron Council
(@Assembly25Ref,45226,0,1,1,1,1), -- Ancient Iron Heaume
(@Assembly25Ref,45235,0,1,1,1,1), -- Radiant Seal
(@Assembly25Ref,45227,0,1,1,1,1), -- Iron-studded Mantle
(@Assembly25Ref,45239,0,1,1,1,1), -- Runeshaper's Gloves
(@Assembly25Ref,45224,0,1,1,1,1), -- Drape of the Lithe
(@Assembly25Ref,45232,0,1,1,1,1), -- Runed Ironhide Boots
(@Assembly25Ref,45228,0,1,1,1,1), -- Handguards of the Enclave
(@Assembly25Ref,45238,0,1,1,1,1), -- Overload Legwraps
-- Cache of Living Stone 10man
(@Kologarn10Ref,45701,0,1,1,1,1), -- Greaves of the Earthbinder
(@Kologarn10Ref,45965,0,1,1,1,1), -- Spire of Withering Dreams
(@Kologarn10Ref,45702,0,1,1,1,1), -- Emerald Signet Ring
(@Kologarn10Ref,45696,0,1,1,1,1), -- Mark of the Unyielding
(@Kologarn10Ref,45698,0,1,1,1,1), -- Sabatons of the Iron Watcher
(@Kologarn10Ref,45697,0,1,1,1,1), -- Shoulderguards of the Solemn Watch
(@Kologarn10Ref,45703,0,2,2,1,1), -- Spark of Hope
(@Kologarn10Ref,45700,0,2,2,1,1), -- Stoneguard
(@Kologarn10Ref,45699,0,2,2,1,1), -- Pendant of the Piercing Glare
(@Kologarn10Ref,45704,0,2,2,1,1), -- Shawl of the Shattered Giant
-- Cache of Living Stone 25man
(@Kologarn25Ref,45261,0,1,1,1,1), -- Giant's Bane
(@Kologarn25Ref,45266,0,1,1,1,1), -- Malice
(@Kologarn25Ref,45274,0,1,1,1,1), -- Leggings of the Stoneweaver
(@Kologarn25Ref,45269,0,1,1,1,1), -- Unfaltering Armguards
(@Kologarn25Ref,45268,0,1,1,1,1), -- Gloves of the Pythonic Guardian
(@Kologarn25Ref,45262,0,1,1,1,1), -- Necklace of Unerring Mettle
(@Kologarn25Ref,45275,0,1,1,1,1), -- Bracers of Unleashed Magic
(@Kologarn25Ref,45272,0,1,1,1,1), -- Robes of the Umbral Brute
(@Kologarn25Ref,45267,0,1,1,1,1), -- Saronite Plated Legguards
(@Kologarn25Ref,45263,0,1,1,1,1), -- Wrathstone
(@Kologarn25Ref,45271,0,1,1,1,1), -- Ironmender
(@Kologarn25Ref,45264,0,1,1,1,1), -- Decimator's Armguards
(@Kologarn25Ref,45265,0,1,1,1,1), -- Shoulderpads of the Monolith
(@Kologarn25Ref,45273,0,1,1,1,1), -- Handwraps of Plentiful Recovery
(@Kologarn25Ref,45270,0,1,1,1,1), -- Idol of the Crying Wind
-- Auriaya 10man
(@Auriaya10Ref,45707,0,1,1,1,1), -- Shieldwall of the Breaker
(@Auriaya10Ref,45708,0,1,1,1,1), -- Archaedas' Lost Legplates
(@Auriaya10Ref,45709,0,1,1,1,1), -- Nimble Climber's Belt
(@Auriaya10Ref,45711,0,1,1,1,1), -- Ironaya's Discarded Mantle
(@Auriaya10Ref,45712,0,1,1,1,1), -- Chestplate of Titanic Fury
(@Auriaya10Ref,45713,0,1,1,1,1), -- Nurturing Touch
(@Auriaya10Ref,45832,0,1,1,1,1), -- Mantle of the Preserver
(@Auriaya10Ref,45864,0,1,1,1,1), -- Cover of the Keepers
(@Auriaya10Ref,45865,0,1,1,1,1), -- Raiments of the Corrupted
(@Auriaya10Ref,45866,0,1,1,1,1), -- Elemental Focus Stone
-- Auriaya 25man
(@Auriaya25Ref,45327,0,1,1,1,1), -- Siren's Cry
(@Auriaya25Ref,45437,0,1,1,1,1), -- Runescribed Blade
(@Auriaya25Ref,45315,0,1,1,1,1), -- Stonerender
(@Auriaya25Ref,45439,0,1,1,1,1), -- Unwavering Stare
(@Auriaya25Ref,45326,0,1,1,1,1), -- Platinum Band of the Aesir
(@Auriaya25Ref,45441,0,1,1,1,1), -- Sandals of the Ancient Keeper
(@Auriaya25Ref,45435,0,1,1,1,1), -- Cowl of the Absolute
(@Auriaya25Ref,45438,0,1,1,1,1), -- Ring of the Faithful Servant
(@Auriaya25Ref,45434,0,1,1,1,1), -- Greaves of the Rockmender
(@Auriaya25Ref,45320,0,1,1,1,1), -- Shoulderplates of the Eternal
(@Auriaya25Ref,45325,0,1,1,1,1), -- Gloves of the Stonereaper
(@Auriaya25Ref,45440,0,1,1,1,1), -- Amice of the Stoic Watch
(@Auriaya25Ref,45334,0,1,1,1,1), -- Unbreakable Chestguard
(@Auriaya25Ref,45319,0,1,1,1,1), -- Cloak of the Makers
(@Auriaya25Ref,45436,0,1,1,1,1); -- Libram of the Resolute

-- ---------------------------
-- -- ASSIGN CREATURE LOOTS -- 
-- ---------------------------
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (@Brundir10,@Molgeim10,@Steelbreaker10,@Brundir25,@Molgeim25,@Steelbreaker25,@Auriaya10,@Auriaya25);
DELETE FROM `creature_loot_template` WHERE `entry` IN (@Brundir10,@Molgeim10,@Steelbreaker10,@Brundir25,@Molgeim25,@Steelbreaker25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ASSEMBLY OF IRON 10-man
-- Stormcaller Brundir killed last
(@Brundir10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Brundir10,45624,100,1,0,1,1), -- 1 Emblem of Triumph
-- Runemaster Molgeim killed last
(@Molgeim10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Molgeim10,45624,100,1,0,2,2), -- 2 Emblem of Triumph
(@Molgeim10,45506,100,2,0,1,1), -- Archivum Data Disc
(@Molgeim10,45087,75,1,0,1,1), -- Runed Orb
-- Steelbreaker killed last
(@Steelbreaker10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Steelbreaker10,45624,100,1,0,2,2), -- 2 Emblem of Triumph
(@Steelbreaker10,45087,75,1,0,1,1), -- Runed Orb
(@Steelbreaker10,45506,100,1,0,1,1), -- Archivum Data Disc for Quest 
(@Steelbreaker10,25455,0,1,1,1,1), -- Belt fo the Crystal Tree
(@Steelbreaker10,45447,0,1,1,1,1), -- Watchful Eye of Fate
(@Steelbreaker10,45456,0,1,1,1,1), -- Loop of the Agile
(@Steelbreaker10,45449,0,1,1,1,1), -- The Masticator
(@Steelbreaker10,45448,0,1,1,1,1), -- Perilous Bite
-- ASSEMBLY OF IRON 25-man
-- Stormcaller Brundir killed last
(@Brundir25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Brundir25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Brundir25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Brundir25,45087,75,1,0,1,1), -- Runed Orb
(@Brundir25,45624,100,1,0,1,2), --  2 Emblems of Triumph
-- Runemaster Molgeim killed last
(@Molgeim25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Molgeim25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Molgeim25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Molgeim25,45087,75,1,0,1,1), -- Runed Orb
(@Molgeim25,45624,100,1,0,2,2), -- 2 Emblems of Triumph
(@Molgeim25,45506,100,1,0,1,1), -- Archivum Data Disc
-- Steelbreaker killed last
(@Steelbreaker25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Steelbreaker25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Steelbreaker25,45038,18,1,0,1,1), -- Fragment of Val'anyr
(@Steelbreaker25,45087,75,1,0,2,2), -- 2x Runed Orb
(@Steelbreaker25,45624,100,1,0,2,2), -- 2 Emblems of Triumph
(@Steelbreaker25,45506,100,1,0,1,1), -- Archivum Data Disc
(@Steelbreaker25,45241,0,1,1,1,1), -- Belt of Colossal Rage
(@Steelbreaker25,45242,0,1,1,1,1), -- Drape of Mortal Downfall
(@Steelbreaker25,45607,0,1,1,1,1), -- Fang of Oblivion
(@Steelbreaker25,45244,0,1,1,1,1), -- Greaves of Swift Vengeance
(@Steelbreaker25,45243,0,1,1,1,1), -- Sapphire Amulet of Renewal
(@Steelbreaker25,45245,0,1,1,1,1); -- Shoulderpads of the Intruder

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (@CacheLivingStone10,@CacheLivingStone25);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- KOLOGARN 10-man
(@CacheLivingStone10,1,100,1,0,-@Kologarn10Ref,2), -- 2 items from reference loot
(@CacheLivingStone10,45624,100,1,0,1,1), -- 1 Emblem of Triumph
-- KOLOGARN 25-Man
(@CacheLivingStone25,1,100,1,0,-@Kologarn25Ref,3), -- 3 items from reference loot
(@CacheLivingStone25,2,10,1,0,-34154,1), -- Chance on Recipe
(@CacheLivingStone25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@CacheLivingStone25,45087,50,1,0,1,1), -- Runed Orb
(@CacheLivingStone25,45624,100,1,0,1,2); -- 2 Emblems of Triumph

DELETE FROM `creature_loot_template` WHERE `entry` IN (@Auriaya10,@Auriaya25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- AURIAYA 10-man
(@Auriaya10,1,100,1,0,-@Auriaya10Ref,2), -- 2 items from reference loot
(@Auriaya10,45624,100,1,0,1,1), -- 1 Emblem of Triumph
-- AURIAYA 25-man
(@Auriaya25,1,100,1,0,-@Auriaya25Ref,3), -- 3 items from reference loot
(@Auriaya25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Auriaya25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Auriaya25,45087,75,1,0,1,1), -- Runed Orb
(@Auriaya25,45624,100,1,0,1,2); -- 2 Emblems of Triumph
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_spinning_pain_spike';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(66316,'spell_spinning_pain_spike'),
(67100,'spell_spinning_pain_spike'),
(67101,'spell_spinning_pain_spike'),
(67102,'spell_spinning_pain_spike');
-- Greater Blessing of Wisdom and Mana Spring Totem should not stack (hotfix)
SET @GROUP := 1117;
DELETE FROM `spell_group` WHERE id=@GROUP;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(@GROUP,25894), -- Greater Blessing of Wisdom
(@GROUP,5677); -- Mana Spring (cast by Mana Spring Totem)
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=@GROUP;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES 
(@GROUP,3); -- Make them SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT
-- Quest: Blending In (11633)
-- Spell from Cape only Appliable in City Area
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=45614;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,45614,11633,23,4125,0,0,0, '', 'Shroud of the Scourge - Temple City of En''kilah');
-- CREATURE_FLAG_EXTRA_NO_XP_AT_KILL
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64 WHERE `entry`=21267; -- Mana Beast
-- Fix quest 11468 - Falcon versus hawk
SET @entry := 24747; -- Fjord Hawk
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@entry;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@entry AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@entry,0,0,1,8,0,100,0,44407,0,0,0,11,44408,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fjord Hawk - On Spellhit - Cast spell on invoker'),
(@entry,0,1,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Fjord Hawk - On Spellhit - Despawn');
UPDATE `conditions` SET `ElseGroup`=0 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=45614; -- typo fix for previous commit
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=47431;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,47431,0,23,4195,0,0,64,'','Capture Jormungar Spawn can only be used in Ice Heart Cavern');
