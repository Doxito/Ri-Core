# La semana de los niños
UPDATE creature_template SET ScriptName="npc_supervisoras_even" WHERE entry IN (14451,14450,22819,34365);
UPDATE quest_template SET RequiredNpcOrGo1='0', RequiredNpcOrGoCount1='0' WHERE id='13927' OR id ='13926';
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('34365','571','1','1','0','0','5812.45','637.931','647.49','5.84188','300','0','0','12600','3994','0','0','0','0');
