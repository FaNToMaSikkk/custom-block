#Waterlogged Breaking
tag @e[tag=tracker,tag=TickCycle] remove TickCycle
execute as @a at @s rotated as @s anchored eyes positioned ^ ^ ^ run function bone_msd:block_engine/raycast/trigger

#Block Breaking
#tag @e[type=item] add Checked
#tag @e[type=minecraft:experience_orb] add Checked
#execute as @e[tag=bone_msd_block] at @s run function bone_msd:block_engine/breaking_check
