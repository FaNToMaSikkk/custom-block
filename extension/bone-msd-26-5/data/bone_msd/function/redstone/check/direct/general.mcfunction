execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:redstone_directs[powered=true] run function bone_msd:redstone/set_power

execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power

