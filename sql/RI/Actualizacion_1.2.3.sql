
insert into `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) values('13','5','29435','0','0','31','0','3','17034','0','0','0','','Ejemplo - SpellTarget');

####################################
 ######      AHN-KANET     #######
####################################

-- Beam Visual
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=60342;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,60342,0,0,31,0,3,29308,0,0,0,'','Beam Visual target Prince Taldaram');

-- script texts for Prince Taldaram
DELETE FROM `creature_text` WHERE `entry`=29308;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29308,0,0,'The hum of magic energy in the air diminishes...',16,0,100,0,0,0,'prince taldaram SAY_1'),
(29308,1,0,'Intruders! Who trespasses in the Old Kingdom?',14,0,100,0,0,0,'prince taldaram SAY_WARNING'),
(29308,2,0,'I will feast on your remains.',14,0,100,0,0,14360,'prince taldaram SAY_AGGRO'),
(29308,3,0,'',14,10,100,0,0,14365,'prince taldaram SAY_SLAY_0'),
(29308,3,1,'I will drink no blood before it''s time.',14,0,100,0,0,14366,'prince taldaram SAY_SLAY_1'),
(29308,3,2,'One final embrace.',14,0,100,0,0,14367,'prince taldaram SAY_SLAY_2'),
(29308,4,0,'Still I hunger. Still... I... thirst.',14,0,100,0,0,14368,'prince taldaram SAY_DEATH'),
(29308,5,0,'So... appetizing.',14,0,100,0,0,14363,'prince taldaram SAY_FEED1'),
(29308,5,1,'Fresh, warm blood. It has been too long.',14,0,100,0,0,14364,'prince taldaram SAY_FEED2'),
(29308,6,0,'Your heartbeat is... music to my ears.',14,0,100,0,0,14361,'prince taldaram SAY_VANISH1'),
(29308,6,1,'I am nowhere... I am everywhere. I am the watcher, unseen.',14,0,100,0,0,14362,'prince taldaram SAY_VANISH2');

-- cleanup
DELETE FROM `script_texts` WHERE `npc_entry`=29308;


####################################
 ###### UPDATES PARA ULDUAR #######
####################################

UPDATE creature_template SET InhabitType='4' WHERE entry IN (33186,33724,34109,33670); -- Tajoescama, Mimiron(Unidad Aérea),
DELETE FROM vehicle_template_accessory where entry ='33293' or entry ='33885' -- Desarmador - Corazón



####################################
 ###### UPDATES  PARA   BT #######
####################################
#Minions de Akama
UPDATE creature_template SET faction_A='1813', faction_H='1813' WHERE entry IN (22847,22846,22849,22845);
#Illidan
-- demon fire
UPDATE `creature_template` SET spell1 = 40029, flags_extra = 128, ScriptName = '' WHERE entry = 23069;
-- pillar of fire
UPDATE `creature_template` SET spell1 = 43218, flags_extra = 128, ScriptName = '' WHERE entry = 24187;
-- Broggok Poison Cloud
UPDATE `creature_template` SET spell1 = 30914, flags_extra = 128, ScriptName = '' WHERE entry = 17662;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (43468, 43648, 43658, 43658, 43658, 43658, 43658);
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43648, 44007, 1, 'Storm Eye Safe Zone');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43658, 43653, 0, 'Electrical Arc Visual');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43658, 43654, 0, 'Electrical Arc Visual');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43658, 43655, 0, 'Electrical Arc Visual');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43658, 43656, 0, 'Electrical Arc Visual');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (43658, 43659, 0, 'Electrical Arc Visual');
DELETE FROM spell_linked_spell WHERE `spell_trigger` IN (39992, 39835, 42052, -41914, -41917, 41126, -41376, 39908);
-- INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (39992, 39835, 1, 'Needle Spine');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (39835, 39968, 1, 'Needle Spine');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-41376, 41377, 0, 'Spite');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (41126, 41131, 1, 'Flame Crash');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-41914, 41915, 0, 'Summon Parasitic Shadowfiend');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-41917, 41915, 0, 'Summon Parasitic Shadowfiend');
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (39908, 40017, 1, 'Eye Blast');

-- spine
update gameobject_template set scriptname = 'go_najentus_spine' where entry = 185584;
-- molten_flame
UPDATE creature_template SET spell1 = 40980, flags_extra = 128, speed = 1.0, scriptname = 'molten_flame' WHERE entry = 23095;
-- volcano
UPDATE creature_template SET spell1 = 40117, flags_extra = 128, scriptname = '' WHERE entry = 23085;
-- flame crash
update creature_template set spell1 = 40836, flags_extra = 128, scriptname = '' where entry = 23336;
-- blaze
update creature_template set spell1 = 40610, flags_extra = 128, scriptname = '' where entry = 23259;
-- glaive
update creature_template set scriptname = 'mob_blade_of_azzinoth' where entry = 22996;
-- parasitic shadowfiend
update creature_template set scriptname = 'mob_parasitic_shadowfiend' where entry = 23498;
-- Maiev
update creature_template set minlevel = 73, maxlevel = 73, minhealth = 500000, maxhealth = 500000, mindmg = 3000, maxdmg = 4000 where entry = 23197;
