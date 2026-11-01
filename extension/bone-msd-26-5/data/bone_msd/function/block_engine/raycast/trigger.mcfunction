kill @e[type=marker,tag=raycast_hit]
scoreboard players set raycast_dist Check 0
function bone_msd:block_engine/raycast/loop

execute as @e[tag=tracker] at @s if block ~ ~ ~ #slabs unless block ~ ~ ~ #slabs[type=double] run tag @s add SingleSlab

execute as @e[tag=SingleSlab] at @s if block ~ ~ ~ #slabs[type=double] run function bone_msd:block_engine/placing/place_slab

kill @e[tag=tracker,tag=!New,tag=!TickCycle]

tag @e[tag=New,tag=!TickCycle] remove New

execute at @e[tag=raycast_hit] align xyz run summon marker ~.5 ~.5 ~.5 {Tags:[tracker, New, TickCycle]}

execute at @e[tag=tracker, tag=!SingleSlab] if block ~ ~ ~ water run setblock ~ ~ ~ air

#kill @e[tag=tracker,tag=!New]

execute as @e[tag=tracker] at @s if block ~ ~ ~ air run kill @s
