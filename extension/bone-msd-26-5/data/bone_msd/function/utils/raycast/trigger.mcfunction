kill @e[type=marker,tag=raycast_hit]
scoreboard players set raycast_dist Check 0
execute anchored eyes run function bone_msd:utils/raycast/loop
