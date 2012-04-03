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
(26393,1,0,15,26394,2,0,0,0,0,0);



-- Argent Tournament Trainers part
SET @SPELL_ON_ARGENT_MOUNT := 63034;

SET @NPC_JAERAN_LOCKWOOD := 33973;
SET @QUEST_MASTERY_OF_MELEE_A := 13828;
SET @QUEST_MASTERY_OF_MELEE_H := 13829;

SET @GOSSIP_MENU_JERAN_MOUNTED := 10398;
SET @GOSSIP_MENU_JERAN_EXPLANATION := 10397; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_JERAN_MOUNTED := 14431;
SET @GOSSIP_TEXT_JERAN_EXPLANATION := 14434;
SET @SPELL_CREDIT_JERAN := 64113;

SET @NPC_RUGAN_STEELBELLY := 33972;
SET @QUEST_MASTERY_OF_CHARGE_A := 13837;
SET @QUEST_MASTERY_OF_CHARGE_H := 13839;

SET @GOSSIP_MENU_RUGAN_MOUNTED := 10400;
SET @GOSSIP_MENU_RUGAN_EXPLANATION := 10399; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_RUGAN_MOUNTED := 14436;
SET @GOSSIP_TEXT_RUGAN_EXPLANATION := 14437;
SET @SPELL_CREDIT_RUGAN := 64114;

SET @NPC_VALIS_WINDCHASER := 33974;
SET @QUEST_MASTERY_OF_SH_BREAKER_A := 13835;
SET @QUEST_MASTERY_OF_SH_BREAKER_H := 13838;

SET @GOSSIP_MENU_VALIS_MOUNTED := 10402;
SET @GOSSIP_MENU_VALIS_EXPLANATION := 10401; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_VALIS_MOUNTED := 14438;
SET @GOSSIP_TEXT_VALIS_EXPLANATION := 14439;
SET @SPELL_CREDIT_VALIS := 64115;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry`IN(@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
DELETE FROM `smart_scripts` WHERE (`entryorguid`IN(@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY) AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC_JAERAN_LOCKWOOD,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_TEXT_JERAN_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send different gossip when mounted (Requires conditions)'),
(@NPC_JAERAN_LOCKWOOD,0,1,3,62,0,100,0,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send text when option clicked'),
(@NPC_JAERAN_LOCKWOOD,0,2,3,62,0,100,0,@GOSSIP_MENU_JERAN_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send text when option clicked'),
(@NPC_JAERAN_LOCKWOOD,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_JERAN,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Give Credit'),
(@NPC_JAERAN_LOCKWOOD,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Close Gossip'),

(@NPC_RUGAN_STEELBELLY,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_TEXT_RUGAN_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send different gossip when mounted (Requires conditions)'),
(@NPC_RUGAN_STEELBELLY,0,1,3,62,0,100,0,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send text when option clicked'),
(@NPC_RUGAN_STEELBELLY,0,2,3,62,0,100,0,@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send text when option clicked'),
(@NPC_RUGAN_STEELBELLY,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_RUGAN,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Give Credit'),
(@NPC_RUGAN_STEELBELLY,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Close Gossip'),

(@NPC_VALIS_WINDCHASER,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_VALIS_MOUNTED,@GOSSIP_TEXT_VALIS_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send different gossip when mounted (Requires conditions)'),
(@NPC_VALIS_WINDCHASER,0,1,3,62,0,100,0,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send text when option clicked'),
(@NPC_VALIS_WINDCHASER,0,2,3,62,0,100,0,@GOSSIP_TEXT_VALIS_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send text when option clicked'),
(@NPC_VALIS_WINDCHASER,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_VALIS,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Give Credit'),
(@NPC_VALIS_WINDCHASER,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`IN(@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`IN(@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_MENU_VALIS_MOUNTED);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,@NPC_JAERAN_LOCKWOOD,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Jeran Lockwood show different menu if player mounted'),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_MELEE_A,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_MELEE_H,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_MELEE_A,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_MELEE_H,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),

(22,1,@NPC_RUGAN_STEELBELLY,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Rugan Steelbelly show different menu if player mounted'),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_CHARGE_A,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_CHARGE_H,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_CHARGE_A,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_CHARGE_H,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),

(22,1,@NPC_VALIS_WINDCHASER,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Valis Windchaser show different menu if player mounted'),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_SH_BREAKER_A,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_SH_BREAKER_H,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_SH_BREAKER_A,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_SH_BREAKER_H,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura");

DELETE FROM `gossip_menu` WHERE `entry` IN (@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_MENU_VALIS_EXPLANATION);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_TEXT_JERAN_EXPLANATION),
(@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_TEXT_RUGAN_EXPLANATION),
(@GOSSIP_MENU_VALIS_EXPLANATION,@GOSSIP_TEXT_VALIS_EXPLANATION);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_MENU_VALIS_MOUNTED,@GOSSIP_MENU_VALIS_EXPLANATION);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP_MENU_JERAN_MOUNTED,0,0,'Show me how to train with a Melee Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_JERAN_MOUNTED,1,0,'Tell me more about Defend and Thrust!',1,1,@GOSSIP_MENU_JERAN_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_JERAN_EXPLANATION,0,0,'Show me how to train with a Melee Target.',1,1,0,0,0,0,''),

(@GOSSIP_MENU_RUGAN_MOUNTED,0,0,'Show me how to train with a Charge Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_RUGAN_MOUNTED,1,0,'Tell me more about the Charge!',1,1,@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,'Show me how to train with a Charge Target.',1,1,0,0,0,0,''),

(@GOSSIP_MENU_VALIS_MOUNTED,0,0,'Show me how to train with a Ranged Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_VALIS_MOUNTED,1,0,'Tell me more about the Shield-Breaker!',1,1,@GOSSIP_MENU_VALIS_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_VALIS_EXPLANATION,0,0,'Show me how to train with a Ranged Target.',1,1,0,0,0,0,'');

DELETE FROM `creature_text` WHERE `entry` IN (@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@NPC_JAERAN_LOCKWOOD,0,0,'Put up defend$B|TInterface\\Icons\\ability_warrior_shieldmastery.blp:32|t$BThen use Thrust on a Melee Target$B|TInterface\\Icons\\inv_sword_65.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Melee Tutorial'),
(@NPC_RUGAN_STEELBELLY,0,0,'Use Shield-Breaker on a Charge Target$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t$BFollow up with Charge while the target is vulnerable$B|TInterface\\Icons\\ability_mount_charger.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Charge Tutorial'),
(@NPC_VALIS_WINDCHASER,0,0,'Use Shield-Breaker on a Ranged Target$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t$BThen use Shield-Breaker while the target is defenseless$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Ranged Tutorial');

-- Training Dummies Part
UPDATE `creature_template` SET `ScriptName` = 'npc_tournament_training_dummy' WHERE `entry` IN (33272,33229,33243);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62709;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62709,0,0,18,1,33845,0,0, '','Counterattack! (Argent Tournament) - Target near aspirant mounts'),
(13,0,62709,0,0,18,1,33323,0,0, '','Counterattack! (Argent Tournament) - Target near aspirant mounts');

DELETE FROM `spell_script_names` WHERE `spell_id`=62709;
INSERT INTO `spell_script_names` VALUES (62709, 'spell_gen_tournament_counterattack');

-- remove aura_required for clickspells on tournament mounts and add more cases (Thanks to @Tassader)
DELETE FROM `npc_spellclick_spells` WHERE npc_entry IN (33842,33796,33798,33791,33792,33799,33843,33800,33795,33790,33793,33794);
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(33842,63791,13668,0,13687,1,0,0,0),-- Aspirant
(33799,62783,13691,0,0,1,0,0,0),-- A Valiant Of Orgrimmar
(33799,62783,13707,0,0,1,0,0,0),-- Valiant Of Orgrimmar
(33796,62784,13693,0,0,1,0,0,0),-- A Valiant Of Sen'jin
(33796,62784,13708,0,0,1,0,0,0),-- Valiant Of Sen'jin
(33792,62785,13694,0,0,1,0,0,0),-- A Valiant Of Thunder Bluff
(33792,62785,13709,0,0,1,0,0,0),-- Valiant Of Thunder Bluff
(33791,62786,13696,0,0,1,0,0,0),-- A Valiant Of Silvermoon
(33791,62786,13711,0,0,1,0,0,0),-- Valiant Of Silvermoon
(33798,62787,13695,0,0,1,0,0,0),-- A Valiant Of Undercity
(33798,62787,13710,0,0,1,0,0,0), -- Valiant Of Undercity
(33843,63792,13667,0,13686,1,0,0,0),-- Aspirant
(33800,62774,13593,0,0,1,0,0,0),-- A Valiant Of Stormwind
(33800,62774,13684,0,0,1,0,0,0),-- Valiant Of Stormwind
(33795,62779,13685,0,0,1,0,0,0),-- A Valiant Of Ironforge
(33795,62779,13703,0,0,1,0,0,0),-- Valiant Of Ironforge
(33793,62780,13688,0,0,1,0,0,0),-- A Valiant Of Gnomregan
(33793,62780,13704,0,0,1,0,0,0),-- Valiant Of Gnomregan
(33790,62781,13690,0,0,1,0,0,0),-- A Valiant Of Exodar
(33790,62781,13705,0,0,1,0,0,0),-- Valiant Of Exodar
(33794,62782,13689,0,0,1,0,0,0),-- A Valiant Of Darnassus
(33794,62782,13706,0,0,1,0,0,0); -- Valiant Of Darnassus
UPDATE `npc_spellclick_spells` SET `aura_required`=0 WHERE `aura_required`=62853;

-- Break-Shield spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62575,62626,64342,64507,64590,64595,64686,65147,66480,68504);
-- Charge spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62874,62960,63661,62563,63003,63010,64591,66481,68282,68284,68321,68498,68501);
-- Defend spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62552,62719,66482);
-- Pennant and summon spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62863,63034,62774,62779,62780,62781,62782,62783,62784,62785,62786,62787,63663,63791,63792,62595,62596,62594,63394,63395,63396,63397,63398,63401,63402,63403,63404,63405,63406,63421,63422,63423,63425,63426,63427,63428,63429,63430,63431,63432,63433,63434,63435,63436,63606,63500,63501,63607,63608,63609);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(62575,'spell_gen_break_shield'),
(62626,'spell_gen_break_shield'),
(64342,'spell_gen_break_shield'),
(64507,'spell_gen_break_shield'),
(64590,'spell_gen_break_shield'),
(64595,'spell_gen_break_shield'),
(64686,'spell_gen_break_shield'),
(65147,'spell_gen_break_shield'),
(66480,'spell_gen_break_shield'),
(68504,'spell_gen_break_shield'),
(62874,'spell_gen_mounted_charge'),
(62960,'spell_gen_mounted_charge'),
(63661,'spell_gen_mounted_charge'),
(62563,'spell_gen_mounted_charge'),
(63003,'spell_gen_mounted_charge'),
(63010,'spell_gen_mounted_charge'),
(64591,'spell_gen_mounted_charge'),
(66481,'spell_gen_mounted_charge'),
(68282,'spell_gen_mounted_charge'),
(68284,'spell_gen_mounted_charge'),
(68321,'spell_gen_mounted_charge'),
(68498,'spell_gen_mounted_charge'),
(68501,'spell_gen_mounted_charge'),
(62552,'spell_gen_defend'),
(62719,'spell_gen_defend'),
(66482,'spell_gen_defend'),
(62863 ,'spell_gen_tournament_duel'),
(63034,'spell_gen_on_tournament_mount'),
(62595,'spell_gen_tournament_pennant'),
(62596,'spell_gen_tournament_pennant'),
(62594,'spell_gen_tournament_pennant'),
(63394,'spell_gen_tournament_pennant'),
(63395,'spell_gen_tournament_pennant'),
(63396,'spell_gen_tournament_pennant'),
(63397,'spell_gen_tournament_pennant'),
(63398,'spell_gen_tournament_pennant'),
(63401,'spell_gen_tournament_pennant'),
(63402,'spell_gen_tournament_pennant'),
(63403,'spell_gen_tournament_pennant'),
(63404,'spell_gen_tournament_pennant'),
(63405,'spell_gen_tournament_pennant'),
(63406,'spell_gen_tournament_pennant'),
(63421,'spell_gen_tournament_pennant'),
(63422,'spell_gen_tournament_pennant'),
(63423,'spell_gen_tournament_pennant'),
(63425,'spell_gen_tournament_pennant'),
(63426,'spell_gen_tournament_pennant'),
(63427,'spell_gen_tournament_pennant'),
(63428,'spell_gen_tournament_pennant'),
(63429,'spell_gen_tournament_pennant'),
(63430,'spell_gen_tournament_pennant'),
(63431,'spell_gen_tournament_pennant'),
(63432,'spell_gen_tournament_pennant'),
(63433,'spell_gen_tournament_pennant'),
(63434,'spell_gen_tournament_pennant'),
(63435,'spell_gen_tournament_pennant'),
(63436,'spell_gen_tournament_pennant'),
(63606,'spell_gen_tournament_pennant'),
(63500,'spell_gen_tournament_pennant'),
(63501,'spell_gen_tournament_pennant'),
(63607,'spell_gen_tournament_pennant'),
(63608,'spell_gen_tournament_pennant'),
(63609,'spell_gen_tournament_pennant'),
(62774,'spell_gen_summon_tournament_mount'),
(62779,'spell_gen_summon_tournament_mount'),
(62780,'spell_gen_summon_tournament_mount'),
(62781,'spell_gen_summon_tournament_mount'),
(62782,'spell_gen_summon_tournament_mount'),
(62783,'spell_gen_summon_tournament_mount'),
(62784,'spell_gen_summon_tournament_mount'),
(62785,'spell_gen_summon_tournament_mount'),
(62786,'spell_gen_summon_tournament_mount'),
(62787,'spell_gen_summon_tournament_mount'),
(63663,'spell_gen_summon_tournament_mount'),
(63791,'spell_gen_summon_tournament_mount'),
(63792,'spell_gen_summon_tournament_mount');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=9798 AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(9798,11,0,0, 'achievement_tilted');

UPDATE `instance_template` SET `script`='instance_scarlet_monastery' WHERE `map`='189';
UPDATE `gameobject_template` SET `ScriptName`='go_loosely_turned_soil' WHERE `entry`='186314';

UPDATE `creature_template` SET `ScriptName`='boss_headless_horseman',
`minlevel`=70, `maxlevel`=70, `minhealth`=67068, `maxhealth`=67068,
`minmana`=3155, `maxmana`=3155, `type`=6
 WHERE `entry` = 23682;

UPDATE `creature_template` SET `ScriptName`='mob_head',
 `minlevel`=70, `maxlevel`=70, `type`=6, `modelid_h`=21908,
`faction_A`=14, `faction_H`=14
WHERE `entry` = 23775;

UPDATE `creature_template` SET `ScriptName`='mob_pulsing_pumpkin',
`faction_A`=14, `faction_H`=14, `type`=6,
`minlevel`=70, `maxlevel`=70,
`minhealth`=9781, `maxhealth`=9781,
`minmana`=3155, `maxmana`=3155
WHERE `entry` = 23694;

-- helper
UPDATE `creature_template` SET `ScriptName`='mob_wisp_invis',
`faction_A`=35, `faction_H`=35,
`unit_flags`='33554434' WHERE `entry`='23686';

-- pumpkin fiend
UPDATE `creature_template` SET
 `minlevel`=70, `maxlevel`=70,
`faction_A`=14, `faction_H`=14,
`type`=6
WHERE `entry`='23545';

-- wisp
UPDATE `creature_template` SET `ScriptName`='mob_wisp_invis',
`modelid_a`=21342, `modelid_h`=21342,
`faction_A`=35, `faction_H`=35, `unit_flags`='33554434'
WHERE `entry`='24034';

UPDATE `creature_template` SET `equipment_id`=23682 WHERE `entry` = 23682;
replace into`creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`)
VALUES (23682, 50495, 0, 0, 33490690, 0, 0, 781, 0, 0);

REPLACE INTO `script_texts` VALUES
(-1189001, 'It is over, your search is done! Let fate choose now, the righteous one',0,0,0,0,0,0,0,0,11961,1,0,'Headless Horseman SAY_ENTRANCE'),

(-1189002, 'Here\'s my body, fit and pure! Now, your blackened souls I\'ll cure!',0,0,0,0,0,0,0,0,12567,1,0,'Headless Horseman SAY_REJOINED'),

(-1189003, 'Over here, you idiot!',0,0,0,0,0,0,0,0,12569,1,0,'Headless Horseman SAY_LOST_HEAD'),

(-1189004, 'Harken, cur! Tis you I spurn! Now, $N, feel the burn!',0,0,0,0,0,0,0,0,12573,1,0,'Headless Horseman SAY_CONFLAGRATION'),

(-1189005, 'Soldiers arise, stand and fight! Bring victory at last to this fallen knight!',0,0,0,0,0,0,0,0,11963,1,0,'Headless Horseman SAY_SPROUTING_PUMPKINS'),

(-1189006, 'Your body lies beaten, battered and broken. Let my curse be your own, fate has spoken',0,0,0,0,0,0,0,0,11962,0,0,'Headless Horseman SAY_PLAYER_DEATH'),

(-1189007, 'This end have I reached before. What new adventure lies in store?',0,0,0,0,0,0,0,0,11964,0,0,'Headless Horseman SAY_DEATH');


UPDATE `creature_template` SET `scriptname`='mob_snobold_vassal', `AIName` ='' WHERE `entry`=34800;

DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (7612,7613);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7612,7613);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(7612,11,0,0, 'achievement_spore_loser'),
(7612,12,0,0,''),
(7613,11,0,0, 'achievement_spore_loser'),
(7613,12,1,0,'');

DELETE FROM `spell_script_names` WHERE `spell_id`=59481;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(59481, 'spell_loatheb_necrotic_aura_warning');


UPDATE `creature_template` SET `ScriptName`='npc_alexstrasza' WHERE `entry`=32295;


UPDATE `creature_template`
    SET `ScriptName` = 'npc_hover_disc'
    WHERE `entry` = 30248;
 
UPDATE `creature_template`
    SET `VehicleId` = 283
    WHERE `entry` = 31748;
 
UPDATE `creature_template`
    SET `VehicleId` = 223
    WHERE `entry` = 31749;
    
    -- bjarngrim's charge up
DELETE FROM `spell_script_names` WHERE `spell_id`=52098;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(52098, 'spell_bjarngrim_charge_up');

-- trigger's charge up
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=56458;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,56458,18,1,28586);

-- cast temporary electrical charge on hit
DELETE FROM `spell_scripts` WHERE `id`=56458;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(56458,0,0,15,52092,2,0,0,0,0,0);

-- bjarngrim's stance auras
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (53790,53791,53792);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(53790,41105,2, 'Bjarngrim - Defensive Aura'),
(53791,41107,2, 'Bjarngrim - Berserker Aura'),
(53792,41106,2, 'Bjarngrim - Battle Aura');

-- achievement: lightning struck
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry`=6835;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=6835 AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(6835,11,0,0, 'achievement_lightning_struck');
    

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62324,63847,64677);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62324, 'spell_throw_passenger'),
(63847, 'spell_flame_leviathan_flame_vents'),
(64677, 'spell_shield_generator');


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
UPDATE creature_template SET ScriptName = "mob_natural_bomb" WHERE entry = 34129;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33168;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33088;
UPDATE creature_template SET ScriptName = "mob_freya_sunbeam" WHERE Entry = 33170;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33168;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33088;
UPDATE creature_template SET faction_A = 16 WHERE Entry = 33168;
UPDATE creature_template SET faction_H = 16 WHERE Entry = 33168;
UPDATE `creature_template` SET `dmg_multiplier`=3.2 WHERE `entry`=32918;
UPDATE `creature_template` SET `dmg_multiplier`=6.4 WHERE `entry`=33399;

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

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62968,65761,62713);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62968, 'spell_elder_essence_targeting'),
(65761, 'spell_elder_essence_targeting'),
(62713, 'spell_elder_essence_targeting');

UPDATE `creature_template` SET `scriptname` = 'boss_keleseth' WHERE `entry` = '23953';
UPDATE `creature_template` SET `scriptname` = 'mob_frost_tomb' WHERE `entry` = '23965';
UPDATE `instance_template` SET `script`='instance_utgarde_keep' WHERE `map`= '574';

-- Script for Yrykul Skeleton - Prince Keleseth Event
UPDATE `creature_template` SET `ScriptName`='mob_vrykul_skeleton' WHERE `entry`=23970;

UPDATE `creature_template` SET `npcflag`=0,`ScriptName`= 'npc_xerestrasza' WHERE `entry`=40429;
UPDATE `creature_template` SET `mindmg`=497,`maxdmg`=676,`attackpower`=795,`dmg_multiplier`=35,`ScriptName`= 'boss_baltharus_the_warborn' WHERE `entry`=39751;
UPDATE `creature_template` SET `exp`=2,`mindmg`=497,`maxdmg`=676,`attackpower`=795,`dmg_multiplier`=70 WHERE `entry`=39920;

DELETE FROM `creature_text` WHERE `entry`=39746; 
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES 
(39746,0,0, 'Alexstrasza has chosen capable allies.... A pity that I must END YOU!',14,0,100,0,0,17512, 'Baltharus the Warborn'),
(39746,1,0, 'You thought you stood a chance?',14,0,50,0,0,17513, 'General Zarithrian'),
(39746,1,1, 'It''s for the best.',14,0,50,0,0,17514, 'General Zarithrian'),
(39746,2,0, 'Turn them to ash, minions!',14,0,100,0,0,17516, 'General Zarithrian'),
(39746,3,0, 'HALION! I...',14,0,100,0,0,17515, 'General Zarithrian');
-- Saviana Ragefire
UPDATE `creature_template` SET `InhabitType`=3,`mechanic_immune_mask`=`mechanic_immune_mask`|8388624,`ScriptName`= 'boss_saviana_ragefire' WHERE `entry`=39747;
DELETE FROM `creature_text` WHERE `entry`=39747; 
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES 
(39747,0,0, 'You will sssuffer for this intrusion!',14,0,100,0,0,17528, 'Saviana Ragefire'),
(39747,1,0, 'Burn in the master''s flame!',14,0,100,0,0,17532, 'Saviana Ragefire'),
(39747,2,0, '%s becomes enraged!',16,0,100,0,0,0, 'Saviana Ragefire'),
(39747,3,0, 'Halion will be pleased.',14,0,100,0,0,17530, 'Saviana Ragefire'),
(39747,3,1, 'As it should be....',14,0,100,0,0,17529, 'Saviana Ragefire');

-- Baltharus the Warborn Clone
UPDATE `creature_template` SET `AIName`= '',`ScriptName`= 'npc_baltarhus_the_warborn_clone' WHERE `entry`=39899;
DELETE FROM `smart_scripts` WHERE `entryorguid`=39899;
UPDATE `creature_template` SET `ScriptName`= 'npc_baltharus_the_warborn_clone' WHERE `ScriptName`= 'npc_baltarhus_the_warborn_clone';
UPDATE `creature_template` SET `InhabitType`=3 WHERE `entry`=39794;
UPDATE `creature_template` SET `ScriptName`= 'boss_general_zarithrian' WHERE `entry`=39746;
UPDATE `creature_template` SET `ScriptName`= 'npc_onyx_flamecaller' WHERE `entry`=39814;


UPDATE `spell_script_names` SET `ScriptName`='spell_elder_ironbranchs_essence_targeting' WHERE `spell_id`=62713;
UPDATE `spell_script_names` SET `ScriptName`='spell_elder_brightleafs_essence_targeting' WHERE `spell_id` IN (62968,65761);



DELETE FROM `spell_script_names` WHERE `spell_id` IN (61698);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(61698,'spell_gen_ds_flush_knockback');
DELETE FROM `spell_dbc` WHERE `id`=61698;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(61698,0,0,536871296,269058048,67108868,268894272,2048,0,1024,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,-1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Flush - Knockback effect');
UPDATE `battleground_template` SET `HordeStartO`=3.14159 WHERE `id`=10;
UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry`=28567;


