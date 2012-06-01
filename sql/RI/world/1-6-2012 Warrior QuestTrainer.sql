-- Warrior
DELETE FROM npc_trainer WHERE (`spell`=20252);
DELETE FROM npc_trainer WHERE (`spell`=71);
DELETE FROM npc_trainer WHERE (`spell`=2458);
DELETE FROM npc_trainer WHERE (`spell`=7386);
DELETE FROM npc_trainer WHERE (`spell`=355);

INSERT INTO `npc_trainer` SELECT `entry`, '20252', '12000', '0', '0', '30'  FROM `creature_template` WHERE `subname`='Warrior Trainer'; -- Intercept
INSERT INTO `npc_trainer` SELECT `entry`, '71', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Warrior Trainer'; -- Defensive Stance
INSERT INTO `npc_trainer` SELECT `entry`, '2458', '3000', '0', '0', '30'  FROM `creature_template` WHERE `subname`='Warrior Trainer'; -- Berserker Stance
INSERT INTO `npc_trainer` SELECT `entry`, '7386', '3000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Warrior Trainer'; -- Sunder Armor
INSERT INTO `npc_trainer` SELECT `entry`, '355', '3000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Warrior Trainer'; -- Taunt 
