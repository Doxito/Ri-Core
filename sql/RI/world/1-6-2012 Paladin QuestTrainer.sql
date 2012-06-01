-- Paladin
DELETE FROM npc_trainer WHERE (`spell`=7328);

INSERT INTO `npc_trainer` SELECT `entry`, '7328', '1200', '0', '0', '12'  FROM `creature_template` WHERE `subname`='Paladin Trainer'; -- Redemption