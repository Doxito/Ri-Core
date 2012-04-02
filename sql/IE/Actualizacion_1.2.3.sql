
insert into `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) values('13','5','29435','0','0','31','0','3','17034','0','0','0','','Ejemplo - SpellTarget');


####################################
 ###### UPDATES PARA ULDUAR #######
####################################

UPDATE creature_template SET InhabitType='4' WHERE entry IN (33186,33724,34109,33670); -- Tajoescama, Mimiron(Unidad Aérea),
DELETE FROM vehicle_template_accessory where entry ='33293' or entry ='33885' -- Desarmador - Corazón