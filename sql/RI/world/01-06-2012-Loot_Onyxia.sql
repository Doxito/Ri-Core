UPDATE creature_loot_template SET item='47241' where (entry='10184' or entry='36538') and item='45624'; # Emblemas de Triunfo
UPDATE creature_loot_template SET maxcount='2' WHERE entry= '10184' and item='1';
UPDATE creature_loot_template SET maxcount='4' WHERE entry= '36538' and item='1';
UPDATE creature_template SET dmg_multiplier='42' where entry='10184';
UPDATE creature_template SET dmg_multiplier='78' where entry='36538';