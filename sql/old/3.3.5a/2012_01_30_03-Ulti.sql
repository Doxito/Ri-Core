UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=15571 AND `item`=21137;
-- Set 25 Heroic loot to 68%
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=68 WHERE `entry`=38586 AND `item`= 50274;
DELETE FROM `disables` WHERE `sourcetype` = 4 AND `entry` IN (7604, 7605);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (28062, 28085, 39090, 39093);
INSERT INTO `spell_script_names`(`spell_id`, `scriptname`) VALUES
(28062, "spell_thaddius_pos_neg_charge"),
(28085, "spell_thaddius_pos_neg_charge"),
(39090, "spell_thaddius_pos_neg_charge"),
(39093, "spell_thaddius_pos_neg_charge");
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7604, 7605) AND `type` IN (18,11);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(7604,11,0,0, 'achievement_polarity_switch'),
(7605,11,0,0, 'achievement_polarity_switch');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (39090, 39093);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(39090, 'spell_capacitus_polarity_shift'),
(39093, 'spell_capacitus_polarity_shift');
-- Make Dame Evniki Kapsalis show vendor gossip option only to players with Crusader title
UPDATE `creature_template` SET `AIName` = 'SmartAI',`ScriptName` = '' WHERE `entry` = 34885;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10598;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`COMMENT`) VALUES
(15,10598,0,0,17,2816,0,0,0,'',"Evniki Kapsalis should only sell to Crusaders"),
(15,10598,0,1,17,2817,0,0,0,'',"Evniki Kapsalis should only sell to Crusaders");

SET @SPELL_CHAIN          = 68341;
SET @NPC_FJOLA_LIGHTBANE  = 36065;
SET @NPC_EYDIS_DARKBANE   = 36066;
SET @NPC_PRIESTESS_ALORAH = 36101;
SET @NPC_PRIEST_GRIMMIN   = 36102;

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN(@NPC_PRIESTESS_ALORAH,@NPC_PRIEST_GRIMMIN);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN(@NPC_PRIESTESS_ALORAH,@NPC_PRIEST_GRIMMIN) AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@NPC_PRIESTESS_ALORAH,0,0,0,1,0,100,1,100,100,0,0,11,@SPELL_CHAIN,0,0,0,0,0,19,@NPC_EYDIS_DARKBANE,0,0,0,0,0,0,'Priestess Alorah - Cast chain on Eydis Darkbane'),
(@NPC_PRIEST_GRIMMIN,0,0,0,1,0,100,1,100,100,0,0,11,@SPELL_CHAIN,0,0,0,0,0,19,@NPC_FJOLA_LIGHTBANE,0,0,0,0,0,0,'Priestess Grimmin - Cast chain on Fjola Lightbane');
-- Scriptname for Refocus spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_refocus';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(24531,'spell_item_refocus');
-- Gushing Wound Removal spell
DELETE FROM `spell_dbc` WHERE `id`=30023;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(30023,0,0,256,0,0,0,0,0,0,0,0,0,0,1,0,0,101,0,0,0,0,26,1,0,-1,0,0,164,164,164,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,35321,38363,39215,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,"Gushing Wound Removal");
DELETE FROM `spell_bonus_data` WHERE `entry` = 63544;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(63544, -1, -1, 0, 0, 'Priest - Empowered Renew');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72618;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,72618,0,0,18,1,0,0,0, '', 'Mutated Plague Clear - target players');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_clear_mutated_plague';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(72618,'spell_putricide_clear_mutated_plague');
