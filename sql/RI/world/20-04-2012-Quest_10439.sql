# Quest 10439
UPDATE quest_template SET RequiredNpcOrGo2='0', RequiredNpcOrGoCount2='0' WHERE id ='10439';
# Npc Saeed
UPDATE creature_template SET ScriptName="q_capitan_Saeed", faction_A='1806', faction_H='1806' where entry='20985';
UPDATE creature_template SET faction_A='1806', faction_H='1806', spell1='0', spell2='0', ScriptName="q_Defensores_Dimens" where entry in (20984,21805,21783);
UPDATE creature_equip_template SET itemEntry2='29438', itemEntry3='29438' where entry='2182';
# Npc Dimensius
UPDATE creature_template SET ScriptName="q_Dimensius",flags_extra='0',unit_flags='0' where entry='19554';
# Npc Spawn Dimensius
UPDATE creature_template SET ScriptName="q_Spawn_Dimensius" where entry='21780';
# Texts
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1000030','¡Prepararos! ¡Vamos a asaltar las forjas de maná!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1000031','¡Es hora de poner fin a esto! ¡Hoy acabaremos contigo, Dimensius!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1000032','¡Estoy hambriento y vosotros seréis mi comida!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values('0','-1000033','¡Prepararos! ¡Atacar!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0',NULL);
