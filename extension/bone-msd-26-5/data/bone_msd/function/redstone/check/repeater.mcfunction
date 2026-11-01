execute if block ~1 ~ ~ repeater[facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ repeater[facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 repeater[facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 repeater[facing=north,powered=true] run function bone_msd:redstone/set_power