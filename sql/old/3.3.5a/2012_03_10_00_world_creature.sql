
-- convert npc to trigger
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=18504;
