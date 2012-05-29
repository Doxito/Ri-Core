#Añadiendo script a Vilebranch Speaker
UPDATE creature_template SET AIName='', ScriptName='mob_Vilebranch_Speaker' WHERE entry='11391';
DELETE FROM creature WHERE id='11391';