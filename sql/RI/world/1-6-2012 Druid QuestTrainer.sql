-- Druid
DELETE FROM npc_trainer WHERE (`spell`=5487);
DELETE FROM npc_trainer WHERE (`spell`=1066);
DELETE FROM npc_trainer WHERE (`spell`=40120);
DELETE FROM npc_trainer WHERE (`spell`=18960);
DELETE FROM npc_trainer WHERE (`spell`=8946);

INSERT INTO `npc_trainer` SELECT `entry`, '5487', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Druid Trainer'; -- Bear Form
INSERT INTO `npc_trainer` SELECT `entry`, '6807', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Druid Trainer'; -- Maul
INSERT INTO `npc_trainer` SELECT `entry`, '6795', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Druid Trainer'; -- Growl
INSERT INTO `npc_trainer` SELECT `entry`, '18960', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Druid Trainer'; -- Teleport: Moonglade
INSERT INTO `npc_trainer` SELECT `entry`, '8946', '2000', '0', '0', '14'  FROM `creature_template` WHERE `subname`='Druid Trainer'; -- Cure Poison