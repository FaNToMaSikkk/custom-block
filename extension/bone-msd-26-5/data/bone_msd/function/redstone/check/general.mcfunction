execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:redstone_components[facing=down,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:redstone_components[facing=up,powered=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:redstone_components[facing=east,powered=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:redstone_components[facing=west,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:redstone_components[facing=south,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:redstone_components[facing=north,powered=true] run function bone_msd:redstone/set_power

execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power

