scoreboard players add raycast_dist Check 1

#execute if block ~ ~ ~ #slabs run scoreboard players set raycast_dist Check 20
#execute if block ~ ~ ~ #slabs run scoreboard players set raycast_dist Check 20

#execute if score raycast_dist Check matches 19.. align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

#execute if score raycast_dist Check matches 19.. positioned ^ ^ ^1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

#execute positioned ^2 ^ ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
#execute positioned ^-2 ^ ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
#execute positioned ^ ^2 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
#execute positioned ^ ^-2 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ^ ^ ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^1 ^ ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^-1 ^ ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ^ ^1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^1 ^1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^-1 ^1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ^ ^-1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^1 ^-1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ^-1 ^-1 ^ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}


execute positioned ^ ^ ^0.5 if score raycast_dist Check matches ..15 run function bone_msd:block_engine/raycast/loop

#execute as @e[tag=raycast_hit] at @s run particle minecraft:flame ~ ~ ~ 0 0 0 0 1 force
