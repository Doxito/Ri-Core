-- Shaman
DELETE FROM npc_trainer WHERE (`spell`=8071);
DELETE FROM npc_trainer WHERE (`spell`=3599);
DELETE FROM npc_trainer WHERE (`spell`=5394);

INSERT INTO `npc_trainer` SELECT `entry`, '8071', '100', '0', '0', '4'  FROM `creature_template` WHERE `subname`='Shaman Trainer'; -- Stoneskin Totem
INSERT INTO `npc_trainer` SELECT `entry`, '3599', '1000', '0', '0', '10'  FROM `creature_template` WHERE `subname`='Shaman Trainer'; -- Searing Totem
INSERT INTO `npc_trainer` SELECT `entry`, '5394', '2000', '0', '0', '20'  FROM `creature_template` WHERE `subname`='Shaman Trainer'; -- Healing Stream Totem 