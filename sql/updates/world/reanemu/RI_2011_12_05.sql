-- Fix Spell Explosive Trap (Hunter) daño periódico nulo
UPDATE `spell_bonus_data` SET `ap_dot_bonus` = '0.1' WHERE `entry` = 13812;-- Fix Paladin Righteous Defense spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_righteous_defense';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(31789,'spell_pal_righteous_defense');DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 46924;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(46924, -13810, 2, 'Bladestorm immune at Frost Trap'),
(46924, -51514, 2, 'Bladestorm immune at Hex'),
(46924, -116, 2, 'Bladestorm immune at FrostBolt'),
(46924, -45524, 2, 'Bladestorm immune at Chains of Ice'),
(46924, -68766, 2, 'Bladestorm immune at Desecration'),
(46924, -58617, 2, 'Bladestorm immune at Glyph of Heart Strike'),
(46924, -605, 2, 'Bladestorm immune at Mind Control');-- Bloodworm AI
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 28017;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 28017;
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(2801701, 28017, 4, 0, 100, 0, 0, 0, 0, 0, 11, 50453, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodworm - Health Leech');