DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_deathbringer_remove_marks';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(72257,'spell_deathbringer_remove_marks');
UPDATE `creature_addon` SET `bytes1`=0x3000000 WHERE `guid`=207210;
UPDATE `creature_addon` SET `bytes1`=0x3000000 WHERE `guid`=207211;
-- SAI for Unrestrained Dragonhawk
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=25236;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=25236 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25236,0,0,1,62,0,100,0,9143,0,0,0,11,45353,0,0,0,0,0,7,0,0,0,0,0,0,0,'Unrestrained Dragonhawk - On Gossip option select - cast "Quest - Sunwell Daily - Ship Bombing Run Return" on player'),
(25236,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Unrestrained Dragonhawk - On Gossip option select - Close Gossip');
-- Unrestrained Dragonhawk Gossip
UPDATE `creature_template` SET `gossip_menu_id`=9143 WHERE `entry`=25236;
-- Gossip_menu from UDB
DELETE FROM `gossip_menu` WHERE `entry`=9143;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9143,12371);
-- Gossip_menu_option Update from UDB
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9143;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9143,0,0, '<Ride the dragonhawk to Sun''s Reach.>',1,1,0,0,0,0, '');
-- Gossip option Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9143;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9143,0,0,9,11542,0,0,0,'','Show gossip option if player has quest 11542 but not complete'),
(15,9143,0,1,9,11543,0,0,0,'','Show gossip option if player has quest 11543 but not complete');
-- Creature Gossip_menu_id Update from sniff
UPDATE `creature_template` SET `gossip_menu_id`=9052 WHERE `entry`=24965; -- Vindicator Xayann 
UPDATE `creature_template` SET `gossip_menu_id`=9050 WHERE `entry`=24975; -- Mar'nah 
UPDATE `creature_template` SET `gossip_menu_id`=9126 WHERE `entry`=25032; -- Eldara Dawnrunner 
UPDATE `creature_template` SET `gossip_menu_id`=9087 WHERE `entry`=25046; -- Smith Hauthaa 
UPDATE `creature_template` SET `gossip_menu_id`=9064 WHERE `entry`=25057; -- Battlemage Arynna 
UPDATE `creature_template` SET `gossip_menu_id`=9062, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=25059; -- Ayren Cloudbreaker 
UPDATE `creature_template` SET `gossip_menu_id`=9063 WHERE `entry`=25061; -- Harbinger Inuuro 
UPDATE `creature_template` SET `gossip_menu_id`=9127 WHERE `entry`=25069; -- Magister Ilastar 
UPDATE `creature_template` SET `gossip_menu_id`=9115 WHERE `entry`=25112; -- Anchorite Ayuri 
UPDATE `creature_template` SET `gossip_menu_id`=9105 WHERE `entry`=25169; -- Archmage Ne'thul
UPDATE `creature_template` SET `gossip_menu_id`=9286 WHERE `entry`=25632; -- Vindicator Moorba
UPDATE `creature_template` SET `gossip_menu_id`=9285 WHERE `entry`=25638; -- Captain Selana
UPDATE `creature_template` SET `gossip_menu_id`=9198 WHERE `entry`=25950; -- Shaani

-- Gossip Menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=9050 AND `text_id`=12237;
DELETE FROM `gossip_menu` WHERE `entry`=9052 AND `text_id`=12241;
DELETE FROM `gossip_menu` WHERE `entry`=9062 AND `text_id`=12252;
DELETE FROM `gossip_menu` WHERE `entry`=9063 AND `text_id`=12256;
DELETE FROM `gossip_menu` WHERE `entry`=9064 AND `text_id`=12258;
DELETE FROM `gossip_menu` WHERE `entry`=9087 AND `text_id`=12286;
DELETE FROM `gossip_menu` WHERE `entry`=9115 AND `text_id`=12323;
DELETE FROM `gossip_menu` WHERE `entry`=9126 AND `text_id`=12338;
DELETE FROM `gossip_menu` WHERE `entry`=9127 AND `text_id`=12340;
DELETE FROM `gossip_menu` WHERE `entry`=9198 AND `text_id`=12497;
DELETE FROM `gossip_menu` WHERE `entry`=9285 AND `text_id`=12596;
DELETE FROM `gossip_menu` WHERE `entry`=9286 AND `text_id`=12597;
DELETE FROM `gossip_menu` WHERE `entry`=9287 AND `text_id`=12598;
DELETE FROM `gossip_menu` WHERE `entry`=9288 AND `text_id`=12599;
DELETE FROM `gossip_menu` WHERE `entry`=9289 AND `text_id`=12600;
DELETE FROM `gossip_menu` WHERE `entry`=9290 AND `text_id`=12601;
DELETE FROM `gossip_menu` WHERE `entry`=9293 AND `text_id`=12604;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9050,12237),
(9052,12241),
(9062,12252),
(9063,12256),
(9064,12258),
(9087,12286),
(9115,12323),
(9126,12338),
(9127,12340),
(9198,12497),
(9285,12596),
(9286,12597),
(9287,12598),
(9288,12599),
(9289,12600),
(9290,12601),
(9293,12604);

-- Creature Gossip_menu_option insert from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9050,9087,9126,9198,9285,9287,9288,9289) AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9062 AND `id` IN (0,1);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9286 AND `id`=2;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(9050,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9062,0,0,'Speaking of action, I''ve been ordered to undertake an air strike.',1,1,0,0,0,0,''), 
(9062,1,0,'I need to intercept the Dawnblade reinforcements.',1,1,0,0,0,0,''),
(9087,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9126,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9198,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9285,0,0,'Give me a situation report, Captain.',1,1,9287,0,0,0,''),
(9286,2,0,'What is the current state of the Sunwell''s Gates?',1,1,9293,0,0,0,''), 
(9287,0,0,'What went wrong?',1,1,9288,0,0,0,''),
(9288,0,0,'Why did they stop?',1,1,9289,0,0,0,''),
(9289,0,0,'Your insight is appreciated.',1,1,9290,0,0,0,'');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9062 AND `SourceEntry` IN (0,1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9062,0,0,0,9,11532,0,0,0,0,'','Show gossip option only if player has taken quest 11532'),
(15,9062,0,0,1,9,11533,0,0,0,0,'','Show gossip option only if player has taken quest 11533'),
(15,9062,1,0,0,9,11542,0,0,0,0,'','Show gossip option only if player has taken quest 11542'),
(15,9062,1,0,1,9,11543,0,0,0,0,'','Show gossip option only if player has taken quest 11543');

-- SmartAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=25059 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25059,0,0,2,62,0,100,0,9062,0,0,0,11,45071,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Cast "Quest - Sunwell Daily - Dead Scar Bombing Run" on player'),
(25059,0,1,2,62,0,100,0,9062,1,0,0,11,45113,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Cast "Quest - Sunwell Daily - Ship Bombing Run" on player'),
(25059,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Close Gossip');

-- Spell scripts from sniff
DELETE FROM `spell_scripts` WHERE `id`=45071;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(45071,2,0,16,12318,1,0,0,0,0,0); -- Play sound
-- ToC missing trigger spawns

SET @GUID            := 2284357; -- Guids libres para la DB de RI.
SET @NPC_TRIGGER1    := 34704; -- Val'kyr Twins Bullet Stalker Dark
SET @NPC_TRIGGER2    := 34720; -- Val'kyr Twins Bullet Stalker Light

UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry` IN (@NPC_TRIGGER1,@NPC_TRIGGER2);
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+61;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID+0,@NPC_TRIGGER1,649,15,1,0,0,619.771,143.71,395.244,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+1,@NPC_TRIGGER1,649,15,1,0,0,515.352,115.349,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+2,@NPC_TRIGGER1,649,15,1,0,0,605.514,103.863,395.29,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+3,@NPC_TRIGGER1,649,15,1,0,0,615.137,156.997,395.28,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+4,@NPC_TRIGGER1,649,15,1,0,0,539.179,184.132,395.282,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+5,@NPC_TRIGGER1,649,15,1,0,0,547.76,184.634,395.289,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+6,@NPC_TRIGGER1,649,15,1,0,0,549.764,86.4444,395.266,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+7,@NPC_TRIGGER1,649,15,1,0,0,511.417,127.158,395.266,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+8,@NPC_TRIGGER1,649,15,1,0,0,597.38,183.672,395.28,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+9,@NPC_TRIGGER1,649,15,1,0,0,573.578,187.665,395.492,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+10,@NPC_TRIGGER1,649,15,1,0,0,620.465,134.66,395.233,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+11,@NPC_TRIGGER1,649,15,1,0,0,560.484,187.743,395.959,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+12,@NPC_TRIGGER1,649,15,1,0,0,577.299,186.854,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+13,@NPC_TRIGGER1,649,15,1,0,0,563.467,81.9323,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+14,@NPC_TRIGGER1,649,15,1,0,0,534.748,92.6424,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+15,@NPC_TRIGGER1,649,15,1,0,0,518.503,170.649,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+16,@NPC_TRIGGER1,649,15,1,0,0,514.566,159.918,395.287,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+17,@NPC_TRIGGER1,649,15,1,0,0,568.049,187.67,395.563,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+18,@NPC_TRIGGER1,649,15,1,0,0,522.955,102.127,395.29,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+19,@NPC_TRIGGER1,649,15,1,0,0,611.656,114.281,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+20,@NPC_TRIGGER1,649,15,1,0,0,616.432,126.418,395.264,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+21,@NPC_TRIGGER1,649,15,1,0,0,526.833,181.783,395.285,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+22,@NPC_TRIGGER1,649,15,1,0,0,578.722,87.4444,395.272,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+23,@NPC_TRIGGER1,649,15,1,0,0,509.743,149.005,395.253,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+24,@NPC_TRIGGER1,649,15,1,0,0,592.736,93.6667,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+25,@NPC_TRIGGER1,649,15,1,0,0,506.038,139.517,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+26,@NPC_TRIGGER1,649,15,1,0,0,608.116,171.731,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+27,@NPC_TRIGGER1,649,15,1,0,0,586.344,184.078,395.283,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+28,@NPC_TRIGGER1,649,15,1,0,0,554.818,187.568,395.288,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+29,@NPC_TRIGGER2,649,15,1,0,0,557.743,187.729,395.915,0,7200,0,0,1,0,0,0,0,0),
(@GUID+30,@NPC_TRIGGER2,649,15,1,0,0,544.094,184.648,395.286,0,7200,0,0,1,0,0,0,0,0),
(@GUID+31,@NPC_TRIGGER2,649,15,1,0,0,551.328,187.646,395.596,0,7200,0,0,1,0,0,0,0,0),
(@GUID+32,@NPC_TRIGGER2,649,15,1,0,0,615.137,150.818,395.269,0,7200,0,0,1,0,0,0,0,0),
(@GUID+33,@NPC_TRIGGER2,649,15,1,0,0,571.158,187.691,395.629,0,7200,0,0,1,0,0,0,0,0),
(@GUID+34,@NPC_TRIGGER2,649,15,1,0,0,606.686,106.731,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+35,@NPC_TRIGGER2,649,15,1,0,0,612.118,118.844,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+36,@NPC_TRIGGER2,649,15,1,0,0,546.057,88.7691,395.284,0,7200,0,0,1,0,0,0,0,0),
(@GUID+37,@NPC_TRIGGER2,649,15,1,0,0,517.722,169.069,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+38,@NPC_TRIGGER2,649,15,1,0,0,507.181,142.285,395.255,0,7200,0,0,1,0,0,0,0,0),
(@GUID+39,@NPC_TRIGGER2,649,15,1,0,0,515.399,159.75,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+40,@NPC_TRIGGER2,649,15,1,0,0,592.151,183.8,395.279,0,7200,0,0,1,0,0,0,0,0),
(@GUID+41,@NPC_TRIGGER2,649,15,1,0,0,510.759,127.333,395.263,0,7200,0,0,1,0,0,0,0,0),
(@GUID+42,@NPC_TRIGGER2,649,15,1,0,0,524.257,178.134,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+43,@NPC_TRIGGER2,649,15,1,0,0,570.779,86.2986,395.253,0,7200,0,0,1,0,0,0,0,0),
(@GUID+44,@NPC_TRIGGER2,649,15,1,0,0,588.675,93.0938,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+45,@NPC_TRIGGER2,649,15,1,0,0,603.528,175.476,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+46,@NPC_TRIGGER2,649,15,1,0,0,509.639,133.26,395.247,0,7200,0,0,1,0,0,0,0,0),
(@GUID+47,@NPC_TRIGGER2,649,15,1,0,0,618.965,139.174,395.288,0,7200,0,0,1,0,0,0,0,0),
(@GUID+48,@NPC_TRIGGER2,649,15,1,0,0,514.785,118.731,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+49,@NPC_TRIGGER2,649,15,1,0,0,581.243,184.062,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+50,@NPC_TRIGGER2,649,15,1,0,0,577.757,184.436,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+51,@NPC_TRIGGER2,649,15,1,0,0,580.486,89.691,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+52,@NPC_TRIGGER2,649,15,1,0,0,511.132,151.156,395.264,0,7200,0,0,1,0,0,0,0,0),
(@GUID+53,@NPC_TRIGGER2,649,15,1,0,0,615.401,130.816,395.263,0,7200,0,0,1,0,0,0,0,0),
(@GUID+54,@NPC_TRIGGER2,649,15,1,0,0,599.307,98.8003,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+55,@NPC_TRIGGER2,649,15,1,0,0,520.212,108.429,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+56,@NPC_TRIGGER2,649,15,1,0,0,610.983,164.696,395.288,0,7200,0,0,1,0,0,0,0,0),
(@GUID+57,@NPC_TRIGGER2,649,15,1,0,0,526.337,99.5556,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+58,@NPC_TRIGGER2,649,15,1,0,0,563.997,187.644,395.489,0,7200,0,0,1,0,0,0,0,0),
(@GUID+59,@NPC_TRIGGER2,649,15,1,0,0,555.695,86.0208,395.253,0,7200,0,0,1,0,0,0,0,0),
(@GUID+60,@NPC_TRIGGER2,649,15,1,0,0,535.924,184.207,395.279,0,7200,0,0,1,0,0,0,0,0),
(@GUID+61,@NPC_TRIGGER2,649,15,1,0,0,538.024,92.441,395.289,0,7200,0,0,1,0,0,0,0,0);
-- Flame Sphere should not be visible to players(only their visual)
UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry` IN (30106,31686,31687);
-- Manual: Heavy Frostweave Bandage should be lootable if you have at least 390 skills in First Aid
UPDATE `conditions` SET `ConditionValue2`=390 WHERE `SourceTypeOrReferenceId`=1 AND `SourceEntry`=39152 AND `ConditionTypeOrReference`=7 AND `ConditionValue1`=129;
DROP TABLE IF EXISTS ip2nation;

CREATE TABLE ip2nation (
  ip int(11) unsigned NOT NULL default '0',
  country char(2) NOT NULL default '',
  KEY ip (ip)
);

DROP TABLE IF EXISTS ip2nationCountries;

CREATE TABLE ip2nationCountries (
  code varchar(4) NOT NULL default '',
  iso_code_2 varchar(2) NOT NULL default '',
  iso_code_3 varchar(3) default '',
  iso_country varchar(255) NOT NULL default '',
  country varchar(255) NOT NULL default '',
  lat float NOT NULL default '0',
  lon float NOT NULL default '0',
  PRIMARY KEY  (code),
  KEY code (code)
);
DELETE FROM `command` WHERE `name` LIKE 'debug moveflags';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug moveflags',3,'Syntax: .debug moveflags [$newMoveFlags [$newMoveFlags2]]\r\nNo params given will output the current moveflags of the target');

DELETE FROM `trinity_string` WHERE `entry` IN(1143,1144);
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(1143,'Target''s moveFlags: %u, moveFlagsExtra: %u.'),
(1144,'Target''s moveFlags set to: %u, moveFlagsExtra to: %u');

-- Spotlight aura for spotlight NPC
DELETE FROM `creature_template_addon` WHERE `entry`=19913;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(19913,0,0,0,0,'39312');

-- Scriptnames for areatriggers
SET @AT_AREA_52_SOUTH := 4472;
SET @AT_AREA_52_NORTH := 4466;
SET @AT_AREA_52_WEST := 4471;
SET @AT_AREA_52_EAST := 4422;
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (@AT_AREA_52_SOUTH,@AT_AREA_52_NORTH,@AT_AREA_52_WEST,@AT_AREA_52_EAST);
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(@AT_AREA_52_SOUTH,"at_area_52_entrance"),(@AT_AREA_52_NORTH,"at_area_52_entrance"),(@AT_AREA_52_WEST,"at_area_52_entrance"),(@AT_AREA_52_EAST,"at_area_52_entrance");
-- Add Area trigger scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (4422,4466,4471,4472);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4422,'at_area_52_entrance'),
(4466,'at_area_52_entrance'),
(4471,'at_area_52_entrance'),
(4472,'at_area_52_entrance');
DELETE FROM `command` WHERE `name` = 'reload locales_creature_text';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload locales_creature_text', 3, 'Syntax: .reload locales_creature_text\nReload locales_creature_text Table.');-- Update gold drops in ICC bosses based on old.wowhead.com data
UPDATE `creature_template` SET `mingold`=250000,`maxgold`=300000 WHERE `entry` IN(36612,37957,37958,37959); -- Lord Marrowgar
UPDATE `creature_template` SET `mingold`=175000,`maxgold`=225000 WHERE `entry` IN (36626,37504,37505,37506); -- Festergut
UPDATE `creature_template` SET `mingold`=400000,`maxgold`=500000 WHERE `entry` IN (36627,38390,38549,38550); -- Rotface
UPDATE `creature_template` SET `mingold`=400000,`maxgold`=500000 WHERE `entry` IN (36678,38431,38585,38586); -- Professor Putricide
UPDATE `creature_template` SET `mingold`=300000,`maxgold`=350000 WHERE `entry` IN (37955,38434,38435,38436); -- Blood-Queen Lana'thel
UPDATE `creature_template` SET `mingold`=1330000,`maxgold`=1400000 WHERE `entry` IN (36853,38265,38266,38267); -- Sindragosa
UPDATE `creature_template` SET `mingold`=1300000,`maxgold`=1500000 WHERE `entry` IN (36597,39166,39167,39168); -- The Lich King
ALTER TABLE `warden_checks` ENGINE=MYISAM;
ALTER TABLE `achievement_dbc` ENGINE=MYISAM;
ALTER TABLE `creature_text` ENGINE=MYISAM;
ALTER TABLE `game_event_seasonal_questrelation` ENGINE=MYISAM;
DROP TABLE IF EXISTS `character_queststatus_seasonal`;
-- SAI for Elrodan
SET @ENTRY=18743;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY*100 AND `source_type`=9);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,5000,8000,15000,25000,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Elrodan - OOC - run script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,11,18744,20,0,0,0,0,0,'Elrodan - Script - Aurosalia say random'),
(@ENTRY*100,9,1,0,0,0,100,0,3000,3000,3000,3000,11,32826,0,0,0,0,0,1,0,0,0,0,0,0,0,'Elrodan - Script - cast Polymorph Cast Visual');
-- Aurosalia fix model
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=18145;
-- Aurosalia text
DELETE FROM `creature_text` WHERE `entry`=18744;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(18744,0,0, 'Stop!',1,0,100,5,0,0, 'Aurosalia'),
(18744,0,1, 'Will you stop--',1,0,100,274,0,0, 'Aurosalia'),
(18744,0,2, '',1,0,100,6,0,0, 'Aurosalia');
-- Aurosalia text
DELETE FROM `creature_text` WHERE `entry`=18744;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(18744,0,0, 'Stop!',12,1,100,5,0,0, 'Aurosalia'),
(18744,0,1, 'Will you stop--',12,1,100,6,0,0, 'Aurosalia'),
(18744,0,2, '',12,1,100,274,0,0, 'Aurosalia');
DELETE FROM `trinity_string` WHERE `entry`=175;
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(175, 'Liquid level: %f, ground: %f, type: %u, flags %u, status: %d.');
-- convert npc to trigger
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=18504;
-- Coilfang Guardian

DELETE FROM `smart_scripts` WHERE `entryorguid`=21873 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(21873, 0, 0, 0, 0, 0, 0, 0, 5000, 5000, 15000, 15000, 11, 28168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Cast Arcing Smash'),
(21873, 0, 1, 0, 0, 0, 0, 0, 2000, 2000, 10000, 10000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Cast Harmstring'),
(21873, 0, 2, 0, 0, 0, 50, 0, 3000, 4000, 10000, 20000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Say 0'); -- randomly guessed timers

DELETE FROM `creature_text` WHERE `entry`=21873;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(21873, 0, 0, 'By Nazjatar''s Depths!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 1, 'Die, warmblood!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 2, 'For the Master!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 3, 'Illidan reigns!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 4, 'My blood is like venom!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=21873;

-- Coilfang Strider

DELETE FROM `smart_scripts` WHERE `entryorguid`=22056 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(22056, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 11, 38257, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - On Reset - Cast Panic Periodic'),
(22056, 0, 1, 0, 0, 0, 0, 0, 8000, 8000, 30000, 40000, 11, 38259, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - IC - Cast Mind Blast');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=22056;

-- Coilfang Elite

DELETE FROM `smart_scripts` WHERE `entryorguid`=22055 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(22055, 0, 0, 0, 0, 0, 0, 0, 5000, 5000, 15000, 20000, 11, 38260, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - IC - Cast Cleave'),
(22055, 0, 1, 0, 0, 0, 0, 0, 2000, 2000, 10000, 10000, 11, 38262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - IC - Cast Harmstring');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=22055;

-- Core Hound

DELETE FROM `smart_scripts` WHERE `entryorguid`=11673 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 11673*100+0 AND 11673*100+5 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(11673, 0, 0, 0, 0, 0, 0, 0, 10000, 10000, 7000, 7000, 11, 19272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Cast Lava Breath'),
(11673, 0, 1, 0, 0, 0, 0, 0, 4000, 4000, 6000, 6000, 11, 19319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Cast Vicious Bite'),
(11673, 0, 2, 0, 0, 0, 0, 0, 15000, 15000, 24000, 24000, 88, 11673*100+0, 11673*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Call random script'),
(11673*100+0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 0 - Cast Ground Stomp'),
(11673*100+1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19366, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 1 - Cast Cauterizing Flames'),
(11673*100+2, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19367, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 2 - Cast Withering Heat'),
(11673*100+3, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19369, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 3 - Cast Ancient Despair'),
(11673*100+4, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19372, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 4 - Cast Ancient Hysteria'),
(11673*100+5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19365, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 5 - Cast Ancient Dread');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=11673;

-- Shadow of Aran

DELETE FROM `smart_scripts` WHERE `entryorguid`=18254 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(18254, 0, 0, 0, 0, 0, 0, 0, 1000, 1000, 5000, 5000, 11, 29978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Aran - IC - Cast Pyro Blast');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=18254;
ALTER TABLE `creature_template` ADD COLUMN `HoverHeight` FLOAT NOT NULL DEFAULT 1 AFTER `InhabitType`;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72257;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,72257,0,0,32,0,144,0,0,0,0,'','Remove Marks of the Fallen Champion - target player');
UPDATE `gameobject_template` SET `flags`=0x32 WHERE `entry` IN (202239,202240,202238,202241,201959,202339,202338,202340);

-- Set Deathbringer's Cache spawned by default
UPDATE `gameobject` SET `spawntimesecs`=604800 WHERE `id` IN (202239,202240,202238,202241);
