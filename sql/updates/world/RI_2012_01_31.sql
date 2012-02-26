SET @ITEM :=50274;
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (28074,28088,28082,28096) AND `item`=@ITEM;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(28074,@ITEM,-38,1,0,1,1), -- Deathbringer Cache 25 Normal
(28088,@ITEM,-68,1,0,1,1), -- Deathbringer Cache 25 Heroic
(28082,@ITEM,-38,1,0,1,1), -- Cache of the Dreamwalker 25 Normal
(28096,@ITEM,-68,1,0,1,1); -- Cache of the Dreamwalker 25 Heroic
-- only drop if someone is on the quest (negative ChanceOrQuestChance) 
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -(ABS(`ChanceOrQuestChance`)) WHERE `item`=50274;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= -(ABS(`ChanceOrQuestChance`)) WHERE `item`=50274;

-- Dreamwalker and Council should drop 3 items
UPDATE `gameobject_loot_template` SET `maxcount`=3 WHERE `entry`IN (28052,28082,28064,28096) AND `item`=1;
UPDATE `creature_loot_template` SET `maxcount`=3 WHERE `entry` IN (37970,38401,38784,38785) AND `item`=1;
SET @ThoriumGems = 12900;
DELETE FROM `reference_loot_template` WHERE `entry` IN (@ThoriumGems,12901,12902,12903,12904,12905,12906,12907,12908);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ThoriumGems
(@ThoriumGems,12363,40,1,1,1,1), -- Arcane Crystal
(@ThoriumGems, 7910,12,1,1,1,1), -- Star Ruby
(@ThoriumGems,12800,12,1,1,1,1), -- Azerothian Diamond
(@ThoriumGems,12361,12,1,1,1,1), -- Blue Sapphire
(@ThoriumGems,12364,12,1,1,1,1), -- Huge Emerald
(@ThoriumGems,12799,12,1,1,1,1); -- Large Opal

SET @Copper := 1502;
SET @Tin := 1503;
SET @Silver := 1504;
SET @Iron := 1505;
SET @Gold :=1506;
SET @Mithril :=1742;
SET @Truesilver := 5045;
SET @SmallThorium := 9597;
SET @RichThorium := 12883;

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (@Copper,@Tin,@Silver,@Iron,@Gold,@Mithril,@Truesilver,@SmallThorium,@RichThorium,17938,13960,17241);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Copper Vein
(@Copper,2770,100,1,0,1,9), -- Copper Ore
(@Copper,2835, 25,1,0,1,11), -- Rough Stone
(@Copper,774 ,5,1,1,1,1), -- Malachite
(@Copper,1210,5,1,1,1,1), -- Shadowgem
(@Copper,818 ,5,1,1,1,1), -- Tigerseye
(@Copper,22634,-100,1,0,1,2), -- Underlight Ore (only on quest)
-- Tin Vein
(@Tin,2771,100,1,0,1,9), -- Tin Ore
(@Tin,2836,25,1,0,1,13), -- Coarse Stone
(@Tin,1206,5,1,1,1,1), -- Moss Agate
(@Tin,1705,5,1,1,1,1), -- Lesser Moonstone
(@Tin,1210,5,1,1,1,1), -- Shadowgem
(@Tin,1529,5,1,1,1,1), -- Jade
(@Tin,2798,-100,1,0,1,2), -- Rethban Ore (only on quest)
(@Tin,22634,-100,1,0,1,2), -- Underlight Ore (only on quest)
-- Silver Vein
(@Silver,2775,100,1,0,2,8), -- Silver Ore
(@Silver,1206,5,1,1,1,1), -- Moss Agate
(@Silver,1705,5,1,1,1,1), -- Lesser Moonstone
(@Silver,1210,5,1,1,1,1), -- Shadowgem
-- Iron Deposit
(@Iron,2772,100,1,0,2,9), -- Iron Ore
(@Iron,2838,100,1,0,2,10), -- Heavy Stone
(@Iron,1529,5,1,1,1,1), -- Jade
(@Iron,3864,5,1,1,1,1), -- Citrine
(@Iron,1705,5,1,1,1,1), -- Lesser Moonstone
(@Iron,7909,5,1,1,1,1), -- Aquamarine
-- Gold Vein
(@Gold,2776,100,1,0,2,8), -- Gold Ore
(@Gold,3864,5,1,1,1,1), -- Citrine
(@Gold,1705,5,1,1,1,1), -- Lesser Moonstone
(@Gold,7909,5,1,1,1,1), -- Aquamarine
-- Mithril Deposit
(@Mithril,3858,100,1,0,1,9), -- Mithril Ore
(@Mithril,7912,80,1,0,1,13), -- Solid Stone
(@Mithril,7909,5,1,1,1,1), -- Aquamarine
(@Mithril,3864,5,1,1,1,1), -- Citrine
(@Mithril,7910,5,1,1,1,1), -- Star Ruby
(@Mithril,9262,5,1,1,1,1), -- Black Vitriol
-- Truesilver Deposit
(@Truesilver,7911,100,1,0,2,8), -- Truesilver Ore
(@Truesilver,7909,5,1,1,1,1), -- Aquamarine
(@Truesilver,3864,5,1,1,1,1), -- Citrine
(@Truesilver,7910,5,1,1,1,1), -- Star Ruby
-- Small Thorium Vein
(@SmallThorium,10620,100,1,0,1,8), -- Thorium Ore
(@SmallThorium,12365,100,1,0,1,10), -- Dense Stone
(@SmallThorium,1,15,1,0,-@ThoriumGems,1), -- One From Gems
-- Rich Thorium Vein
(@RichThorium,10620,100,1,0,3,10), -- Thorium Ore
(@RichThorium,12365,100,1,0,4,12), -- Dense Stone
(@RichThorium,1,25,1,0,-@ThoriumGems,1), -- One From Gems
-- Special Cases:
-- Truesilver Vein+Tainted Vitriol
(17938,7911,100,1,0,2,8), -- Truesilver Ore
(17938,7909,5,1,1,1,1), -- Aquamarine
(17938,3864,5,1,1,1,1), -- Citrine
(17938,7910,5,1,1,1,1), -- Star Ruby
(17938,11513,50,1,0,1,1), -- Tainted Vitriol
-- Small Thorium Vein+Tainted Vitriol
(13960,10620,100,1,0,1,8), -- Thorium Ore
(13960,12365,100,1,0,1,10), -- Dense Stone
(13960,1,15,1,0,-@ThoriumGems,1), -- One From Gems
(13960,11513,50,1,0,1,1), -- Tainted Vitriol
-- Hakkari Thorium Vein
(17241,10620,100,1,0,1,8), -- Thorium Ore
(17241,12365,100,1,0,1,10), -- Dense Stone
(17241,1,15,1,0,-@ThoriumGems,1), -- One From Gems
(17241,19774,40,1,0,5,10); -- Souldarite

-- Delete the criteria from the disables table
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry`=3880;

-- criteria data for achievement Not So Fast
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=3880;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `TYPE`, `value1`, `value2`, `ScriptName`) VALUES
(3880,6,3277,0, ''),
(3880,7,23451,0, '');
-- Make Dame Evniki Kapsalis show vendor gossip option only to players with Crusader title
UPDATE `creature_template` SET `AIName` = 'SmartAI',`ScriptName` = '' WHERE `entry` = 34885;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10598;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`COMMENT`) VALUES
(15,10598,0,0,17,2816,0,0,0,'',"Evniki Kapsalis should only sell to Crusaders"),
(15,10598,0,1,17,2817,0,0,0,'',"Evniki Kapsalis should only sell to Crusaders");

SET @SPELL_CHAIN          = 68341;
SET @NPC_FJOLA_LIGHTBANE  = 36065;
SET @NPC_EYDIS_DARKBANE   = 36066;
SET @NPC_PRIESTESS_ALORAH = 36101;
SET @NPC_PRIEST_GRIMMIN   = 36102;

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN(@NPC_PRIESTESS_ALORAH,@NPC_PRIEST_GRIMMIN);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN(@NPC_PRIESTESS_ALORAH,@NPC_PRIEST_GRIMMIN) AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@NPC_PRIESTESS_ALORAH,0,0,0,1,0,100,1,100,100,0,0,11,@SPELL_CHAIN,0,0,0,0,0,19,@NPC_EYDIS_DARKBANE,0,0,0,0,0,0,'Priestess Alorah - Cast chain on Eydis Darkbane'),
(@NPC_PRIEST_GRIMMIN,0,0,0,1,0,100,1,100,100,0,0,11,@SPELL_CHAIN,0,0,0,0,0,19,@NPC_FJOLA_LIGHTBANE,0,0,0,0,0,0,'Priestess Grimmin - Cast chain on Fjola Lightbane');
-- Scriptname for Refocus spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_refocus';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(24531,'spell_item_refocus');
-- Quest Elven Legends (7481, 7482)
-- Skeletal Remains of Kariel Winthalus SAI
SET @ENTRY  := 179544; -- GO entry
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,62,0,100,0,5743,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Skeletal Remains of Kariel Winthalus - On Gossip option select - run script'),
(@ENTRY,1,1,0,62,0,100,0,5743,1,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Skeletal Remains of Kariel Winthalus - On Gossip option select - run script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Skeletal Remains of Kariel Winthalus - Script - Close Gossip'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Skeletal Remains of Kariel Winthalus - Script - Store target'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,100,1,0,0,0,0,0,11,14368,30,0,0,0,0,0, 'Skeletal Remains of Kariel Winthalus - Script - Send target'),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,14368,30,0,0,0,0,0,'Skeletal Remains of Kariel Winthalus - Script - Set data 0 1 for entry 14368'),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,9,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skeletal Remains of Kariel Winthalus - Script - Deactivate self'),
(@ENTRY*100,9,5,0,0,0,100,0,28000,28000,28000,28000,32,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skeletal Remains of Kariel Winthalus - Script - Activate self');
-- Lorekeeper Lydros SAI
SET @ENTRY := 14368; -- NPC entry
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,0,1,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Lorekeeper Lydros - On dataset - run script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lorekeeper Lydros - Script - set data 0 0'),
(@ENTRY*100,9,1,0,0,0,100,0,1000,1000,1000,1000,66,0,0,0,0,0,0,12,1,0,0,0,0,0,0,'Lorekeeper Lydros - Script - turn to player'),
(@ENTRY*100,9,2,0,0,0,100,0,1000,1000,1000,1000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lorekeeper Lydros - Script - Say 0'),
(@ENTRY*100,9,3,0,0,0,100,0,4000,4000,4000,4000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lorekeeper Lydros - Script - Say 1'),
(@ENTRY*100,9,4,0,0,0,100,0,8000,8000,8000,8000,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lorekeeper Lydros - Script - Say 2'),
(@ENTRY*100,9,5,0,0,0,100,0,11000,11000,11000,11000,15,7481,0,0,0,0,0,12,1,0,0,0,0,0,0,'Lorekeeper Lydros - Script - quest credit'),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,15,7482,0,0,0,0,0,12,1,0,0,0,0,0,0,'Lorekeeper Lydros - Script - quest credit'),
(@ENTRY*100,9,7,0,0,0,100,0,2000,2000,2000,2000,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lorekeeper Lydros - Script - reset orientation');
-- NPC talk text insert
DELETE FROM `creature_text` WHERE `entry`=14368;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(14368,0,0, 'I very much doubt that he will have anything to say, stranger...',12,0,100,1,0,0, 'Lorekeeper Lydros'),
(14368,1,0, 'I personally did not mind him. It was the Prince who took exception to a high elf in his domain. Alas, I am not one to question the Prince. In his defense, he did not incinerate Master Winthalus immediately.',12,0,100,1,0,0, 'Lorekeeper Lydros'),
(14368,2,0, 'We most definitely do not need anymore attention drawn to us, stranger. Return to those that sent you in search of the lost master and tell them that nothing could be found. When this is done - and I will know when it is so - return and I shall reveal the secrets of the deceased.',12,0,100,1,0,0, 'Lorekeeper Lydros');
-- Gossip Fix from nelegalno
DELETE FROM `gossip_menu_option` WHERE `menu_id`=5743;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(5743,0,0,"Mourn the great loss.",1,1,0,0,0,0,NULL), -- A gossip
(5743,1,0,"Mourn the great loss.",1,1,0,0,0,0,NULL); -- H gossip
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=15 AND `SourceGroup`=5743);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,5743,0,0,9,7482,0,0,0,'',"Display gossip option when on Elven Legends A quest"),
(15,5743,1,0,9,7481,0,0,0,'',"Display gossip option when on Elven Legends H quest");
-- DB/Faction change: Add some missing items
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (47711) AND horde_id IN (47870);
INSERT INTO `player_factionchange_items` (`race_A`,`alliance_id`,`commentA`,`race_H`,`horde_id`,`commentH`) VALUES 
(0,47711, 'Girdle of the Nether Champion',0,47870, 'Belt of the Nether Championt');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (26374);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(26374,'spell_gen_elune_candle');

-- Set Gigant Spotlight as not selectable
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=15902;

DELETE FROM `creature_template_addon` WHERE (`entry`IN(15902,15466));
INSERT INTO `creature_template_addon`(`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(15466,0,0,0,0,0,17327), -- Add spirit particles to Omen minions
(15902,0,0,0,0,0,50236); -- Add Spotlight aura to Gigant Spotlight (ummoned by 26392 on Omen's death)

UPDATE `creature_template` SET `ScriptName`='npc_giant_spotlight' WHERE `entry`=15902;
UPDATE `creature_template` SET `RegenHealth`=0,`ScriptName`='npc_omen' WHERE `entry`=15467;
UPDATE `creature_template` SET `ScriptName`='npc_firework',`AIName`='',`faction_A`=35,`faction_H`=35,`unit_flags`=33555200 WHERE `entry` IN (15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15872,15873,15874,15875,15876,15877,15911,15912,15913,15914,15915,15916,15918);
-- Cleanup EventAI and SmartAI
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15872,15873,15874,15875,15876,15877,15911,15912,15913,15914,15915,15916,15918);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15872,15873,15874,15875,15876,15877,15911,15912,15913,15914,15915,15916,15918);

-- Update al targeting stuff for Fireworks and Rocket clusters
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (26294,26295,26333,26334,26336,26337,26338,26488,26490,26517,26521,26344,26347,26345,26348,26349,26351,26352,26354,26355,26356);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
-- Targeting Firework Launcher
(13,0,26294,0,18,0,180771,0,0,'',"Small White Rocket target Firework Launcher"),
(13,0,26294,0,18,0,180850,0,0,'',"Small White Rocket target Firework Launcher"),
(13,0,26294,0,18,0,180868,0,0,'',"Small White Rocket target Firework Launcher"),
(13,0,26295,0,18,0,180771,0,0,'',"Small Yellow Rocket target Firework Launcher"),
(13,0,26295,0,18,0,180850,0,0,'',"Small Yellow Rocket target Firework Launcher"),
(13,0,26295,0,18,0,180868,0,0,'',"Small Yellow Rocket target Firework Launcher"),
(13,0,26333,0,18,0,180771,0,0,'',"Large Blue Rocket target Firework Launcher"),
(13,0,26333,0,18,0,180850,0,0,'',"Large Blue Rocket target Firework Launcher"),
(13,0,26333,0,18,0,180868,0,0,'',"Large Blue Rocket target Firework Launcher"),
(13,0,26334,0,18,0,180771,0,0,'',"Large Green Rocket target Firework Launcher"),
(13,0,26334,0,18,0,180850,0,0,'',"Large Green Rocket target Firework Launcher"),
(13,0,26334,0,18,0,180868,0,0,'',"Large Green Rocket target Firework Launcher"),
(13,0,26336,0,18,0,180771,0,0,'',"Large Red Rocket target Firework Launcher"),
(13,0,26336,0,18,0,180850,0,0,'',"Large Red Rocket target Firework Launcher"),
(13,0,26336,0,18,0,180868,0,0,'',"Large Red Rocket target Firework Launcher"),
(13,0,26337,0,18,0,180771,0,0,'',"Large White Rocket target Firework Launcher"),
(13,0,26337,0,18,0,180850,0,0,'',"Large White Rocket target Firework Launcher"),
(13,0,26337,0,18,0,180868,0,0,'',"Large White Rocket target Firework Launcher"),
(13,0,26338,0,18,0,180771,0,0,'',"Large Yellow Rocket target Firework Launcher"),
(13,0,26338,0,18,0,180850,0,0,'',"Large Yellow Rocket target Firework Launcher"),
(13,0,26338,0,18,0,180868,0,0,'',"Large Yellow Rocket target Firework Launcher"),
-- Targeting Cluster Launcher
(13,0,26488,0,18,0,180772,0,0,'',"Large Blue Rocket Cluster target Cluster Launcher"),
(13,0,26488,0,18,0,180859,0,0,'',"Large Blue Rocket Cluster target Cluster Launcher"),
(13,0,26488,0,18,0,180869,0,0,'',"Large Blue Rocket Cluster target Cluster Launcher"),
(13,0,26488,0,18,0,180874,0,0,'',"Large Blue Rocket Cluster target Cluster Launcher"),
(13,0,26490,0,18,0,180772,0,0,'',"Large Green Rocket Cluster target Cluster Launcher"),
(13,0,26490,0,18,0,180859,0,0,'',"Large Green Rocket Cluster target Cluster Launcher"),
(13,0,26490,0,18,0,180869,0,0,'',"Large Green Rocket Cluster target Cluster Launcher"),
(13,0,26490,0,18,0,180874,0,0,'',"Large Green Rocket Cluster target Cluster Launcher"),
(13,0,26517,0,18,0,180772,0,0,'',"Large Red Rocket Cluster target Cluster Launcher"),
(13,0,26517,0,18,0,180859,0,0,'',"Large Red Rocket Cluster target Cluster Launcher"),
(13,0,26517,0,18,0,180869,0,0,'',"Large Red Rocket Cluster target Cluster Launcher"),
(13,0,26517,0,18,0,180874,0,0,'',"Large Red Rocket Cluster target Cluster Launcher"),
(13,0,26521,0,18,0,180772,0,0,'',"Lucky Lunar rocket Cluster target Cluster Launcher"),
(13,0,26521,0,18,0,180859,0,0,'',"Lucky Lunar rocket Cluster target Cluster Launcher"),
(13,0,26521,0,18,0,180869,0,0,'',"Lucky Lunar rocket Cluster target Cluster Launcher"),
(13,0,26521,0,18,0,180874,0,0,'',"Lucky Lunar rocket Cluster target Cluster Launcher"),
-- Targeting Firework Launcher (Again)
(13,0,26347,0,18,0,180771,0,0,'',"Rocket, RED target Firework Launcher"),
(13,0,26347,0,18,0,180850,0,0,'',"Rocket, RED target Firework Launcher"),
(13,0,26347,0,18,0,180868,0,0,'',"Rocket, RED target Firework Launcher"),
(13,0,26344,0,18,0,180771,0,0,'',"Rocket, BLUE target Firework Launcher"),
(13,0,26344,0,18,0,180850,0,0,'',"Rocket, BLUE target Firework Launcher"),
(13,0,26344,0,18,0,180868,0,0,'',"Rocket, BLUE target Firework Launcher"),
(13,0,26345,0,18,0,180771,0,0,'',"Rocket, GREEEN target Firework Launcher"),
(13,0,26345,0,18,0,180850,0,0,'',"Rocket, GREEEN target Firework Launcher"),
(13,0,26345,0,18,0,180868,0,0,'',"Rocket, GREEEN target Firework Launcher"),
(13,0,26348,0,18,0,180771,0,0,'',"Rocket, WHITE target Firework Launcher"),
(13,0,26348,0,18,0,180850,0,0,'',"Rocket, WHITE target Firework Launcher"),
(13,0,26348,0,18,0,180868,0,0,'',"Rocket, WHITE target Firework Launcher"),
(13,0,26349,0,18,0,180771,0,0,'',"Rocket, YELLOW target Firework Launcher"),
(13,0,26349,0,18,0,180850,0,0,'',"Rocket, YELLOW target Firework Launcher"),
(13,0,26349,0,18,0,180868,0,0,'',"Rocket, YELLOW target Firework Launcher"),
(13,0,26351,0,18,0,180771,0,0,'',"Rocket, BLUE BIG target Firework Launcher"),
(13,0,26351,0,18,0,180850,0,0,'',"Rocket, BLUE BIG target Firework Launcher"),
(13,0,26351,0,18,0,180868,0,0,'',"Rocket, BLUE BIG target Firework Launcher"),
(13,0,26352,0,18,0,180771,0,0,'',"Rocket, GREEN BIG target Firework Launcher"),
(13,0,26352,0,18,0,180850,0,0,'',"Rocket, GREEN BIG target Firework Launcher"),
(13,0,26352,0,18,0,180868,0,0,'',"Rocket, GREEN BIG target Firework Launcher"),
(13,0,26354,0,18,0,180771,0,0,'',"Rocket, RED BIG target Firework Launcher"),
(13,0,26354,0,18,0,180850,0,0,'',"Rocket, RED BIG target Firework Launcher"),
(13,0,26354,0,18,0,180868,0,0,'',"Rocket, RED BIG target Firework Launcher"),
(13,0,26355,0,18,0,180771,0,0,'',"Rocket, WHITE BIG target Firework Launcher"),
(13,0,26355,0,18,0,180850,0,0,'',"Rocket, WHITE BIG target Firework Launcher"),
(13,0,26355,0,18,0,180868,0,0,'',"Rocket, WHITE BIG target Firework Launcher"),
(13,0,26356,0,18,0,180771,0,0,'',"Rocket, YELLOW BIG target Firework Launcher"),
(13,0,26356,0,18,0,180850,0,0,'',"Rocket, YELLOW BIG target Firework Launcher"),
(13,0,26356,0,18,0,180868,0,0,'',"Rocket, YELLOW BIG target Firework Launcher");

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=15466;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=15466 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15466,0,0,0,8,0,100,0,26636,0,8000,9000,11,25495,0,0,0,0,0,1,0,0,0,0,0,0,0,"Minion of Omen - Cast Firework Dazzled when hitted by Elune's Candle firework");

-- Cast quest credit spell when getting Elune's Blessing buff
DELETE FROM `spell_scripts` WHERE `id`=26393;
INSERT INTO `spell_scripts`(`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(26393,1,0,15,26394,2,0,0,0,0,0);-- Class Condition update to use flags
UPDATE `conditions` SET `ConditionValue1`=8 WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21194 AND `ConditionTypeOrReference`=15;
UPDATE `conditions` SET `ConditionValue1`=128 WHERE `SourceTypeOrReferenceId` IN (14,15) AND`SourceGroup`=4486 AND `ConditionTypeOrReference`=15;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=20 AND `SourceEntry` IN (13104,13105) AND `ConditionTypeOrReference`=15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(20,0,13104,1,15,1503,0,0,0,'','Show quest 13104 if player is not a Death Knight'),
(20,0,13105,1,15,32,0,0,0,'','Show quest 13105 if player is a Death Knight');
-- Race Condition update to use flags
UPDATE `conditions` SET `ConditionValue1`=128 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24101 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=32 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24102 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=16 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24103 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=64 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24106 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=4 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24107 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=8 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=24108 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=512 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=69530 AND `ConditionTypeOrReference`=16;
UPDATE `conditions` SET `ConditionValue1`=1024 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=69533 AND `ConditionTypeOrReference`=16;ALTER TABLE `conditions` ADD COLUMN `SourceId` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER SourceEntry;
-- Gushing Wound Removal spell
DELETE FROM `spell_dbc` WHERE `id`=30023;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(30023,0,0,256,0,0,0,0,0,0,0,0,0,0,1,0,0,101,0,0,0,0,26,1,0,-1,0,0,164,164,164,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,35321,38363,39215,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,"Gushing Wound Removal");
DELETE FROM `spell_bonus_data` WHERE `entry` = 63544;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(63544, -1, -1, 0, 0, 'Priest - Empowered Renew');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 57908 AND `spell_effect` = 57915;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(57908,57915,0,'q13129 - Give quest item');
ALTER TABLE `conditions` CHANGE `SourceId` `SourceId` INT(10) NOT NULL DEFAULT '0';
ALTER TABLE `conditions` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72618;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,72618,0,0,18,1,0,0,0, '', 'Mutated Plague Clear - target players');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_clear_mutated_plague';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(72618,'spell_putricide_clear_mutated_plague');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=15571 AND `item`=21137;
-- Set 25 Heroic loot to 68%
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=68 WHERE `entry`=38586 AND `item`= 50274;
