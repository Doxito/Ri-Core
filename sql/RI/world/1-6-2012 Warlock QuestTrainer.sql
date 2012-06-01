-- Warlock
DELETE FROM npc_trainer WHERE (`spell`=697);
DELETE FROM npc_trainer WHERE (`spell`=712);
DELETE FROM npc_trainer WHERE (`spell`=691);
DELETE FROM npc_trainer WHERE (`spell`=1122);
DELETE FROM npc_trainer WHERE (`spell`=18540);

INSERT INTO `npc_trainer` SELECT `entry`, '697', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Warlock Trainer'; -- Summon Voidwalker
INSERT INTO `npc_trainer` SELECT `entry`, '712', '2000', '0', '0', '20'  FROM `creature_template` WHERE `subname`='Warlock Trainer'; -- Summon Succubus
INSERT INTO `npc_trainer` SELECT `entry`, '691', '3000', '0', '0', '30'  FROM `creature_template` WHERE `subname`='Warlock Trainer'; -- Summon Felhunter
INSERT INTO `npc_trainer` SELECT `entry`, '1122', '5000', '0', '0', '50'  FROM `creature_template` WHERE `subname`='Warlock Trainer'; -- Summon Inferno
INSERT INTO `npc_trainer` SELECT `entry`, '18540', '5000', '0', '0', '60'  FROM `creature_template` WHERE `subname`='Warlock Trainer'; -- Ritual of Doom