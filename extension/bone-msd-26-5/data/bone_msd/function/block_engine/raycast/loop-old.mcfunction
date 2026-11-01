scoreboard players add raycast_dist Check 1

execute if block ~ ~ ~ spawner run scoreboard players set raycast_dist Check 81
execute if block ~ ~ ~ #slabs run scoreboard players set raycast_dist Check 81

execute if score raycast_dist Check matches 80.. align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~1 ~ ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~ ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~ ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~ ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~ ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~ ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~ ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~ ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}



execute positioned ~1 ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~1 ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~-1 ~ align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}



execute positioned ~ ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~ ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~ ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}



execute positioned ~1 ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~1 ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}




execute positioned ~1 ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~1 ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~1 ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~-1 ~1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ~-1 ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ spawner unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}
execute positioned ~-1 ~-1 ~-1 align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ #slabs unless entity @e[tag=raycast_hit,distance=..0.5] run summon marker ~ ~ ~ {Tags:[raycast_hit]}


execute positioned ^ ^ ^0.1 if score raycast_dist Check matches ..70 run function bone_msd:block_engine/raycast/loop
