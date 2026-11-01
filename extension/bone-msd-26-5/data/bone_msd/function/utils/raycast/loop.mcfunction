scoreboard players add raycast_dist Check 1

execute unless block ~ ~ ~ #air run scoreboard players set raycast_dist Check 701

execute if score raycast_dist Check matches 700.. run summon marker ~ ~ ~ {Tags:[raycast_hit]}

execute positioned ^ ^ ^0.1 if score raycast_dist Check matches ..700 run function bone_msd:utils/raycast/loop
