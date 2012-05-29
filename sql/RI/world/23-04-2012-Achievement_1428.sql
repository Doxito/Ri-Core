#Logro Barredor de minas
DELETE FROM `disables` WHERE `SourceType`=4 and `entry`=5258;
UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry`=29397; 
UPDATE gameobject_template SET data3='54402' WHERE entry='191502';

DELETE FROM `spell_script_names` WHERE `spell_id` =57099;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(57099,'spell_gen_logro_barredor_minas');

insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('54402','23462','0','Daño');
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('54402','57099','0','Logro Barre-Minas');
insert into `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) values('54402','64079','1','Visual');

