-- Hunter
DELETE FROM npc_trainer WHERE (`spell`=883);
DELETE FROM npc_trainer WHERE (`spell`=6991);
DELETE FROM npc_trainer WHERE (`spell`=2641);
DELETE FROM npc_trainer WHERE (`spell`=982);
DELETE FROM npc_trainer WHERE (`spell`=1515);

INSERT INTO `npc_trainer` SELECT `entry`, '883', '2000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Hunter Trainer'; -- Call Pet
INSERT INTO `npc_trainer` SELECT `entry`, '6991', '2000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Hunter Trainer'; -- Feed Pet
INSERT INTO `npc_trainer` SELECT `entry`, '2641', '2000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Hunter Trainer'; -- Dismiss Pet
INSERT INTO `npc_trainer` SELECT `entry`, '982', '2000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Hunter Trainer'; -- Revive Pet
INSERT INTO `npc_trainer` SELECT `entry`, '1515', '2000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Hunter Trainer'; -- Tame Beast