execute if block ~1 ~ ~ minecraft:comparator[facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ minecraft:comparator[facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 minecraft:comparator[facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 minecraft:comparator[facing=north,powered=true] run function bone_msd:redstone/set_power