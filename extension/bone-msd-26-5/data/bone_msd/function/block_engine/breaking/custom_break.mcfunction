$loot replace entity @n[type=item,distance=..0.5] contents loot $(loot_table)
kill @e[type=minecraft:experience_orb,distance=..0.5,tag=!old]
kill @s
