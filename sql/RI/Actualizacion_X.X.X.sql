####################################################
  ###############   QUESTS   #####################
####################################################

#  Quest - 12253 - Rescátalos de Plaza de la Ciudad
UPDATE FROM creature_template set AIName='SmartAI' where entry in (27359);
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('27359','0','0','1','10','0','100','1','1','2','30000','30000','33','27359','0','0','0','0','0','7','0','0','0','0','0','0','0','q- 12253');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('27359','0','1','0','61','0','100','0','0','0','0','0','41','3000','0','0','0','0','0','0','0','0','0','0','0','0','0','q- 12253');
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values('27359','0','2','0','2','0','100','1','1','40','2000','2000','24','0','0','0','0','0','0','0','0','0','0','0','0','0','0','q- 12253');















#  Quest - 12253 - Rescátalos de Plaza de la Ciudad
#
#
#