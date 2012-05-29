# Quest 12589
insert into `spell_script_names` (`spell_id`, `ScriptName`) values('51330','spell_q12589_shoot_RJR');

#Remplazo de criaturas
DELETE FROM creature WHERE id IN (28054,28053);
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('28053','571','1','1','0','0','5535.94','5752.43','-77.4932','6.12435','300','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('28054','571','1','1','0','0','5535.94','5752.43','-78.5707','6.09686','300','0','0','11379','0','0','0','0','0');

#Retirando Vehicle
UPDATE creature_template SET VehicleId='0' where entry='28054';
UPDATE creature_template SET InhabitType='4' where entry='28053';

