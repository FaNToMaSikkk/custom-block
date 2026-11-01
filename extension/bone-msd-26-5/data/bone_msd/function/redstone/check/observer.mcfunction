execute if block ~1 ~ ~ observer[facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ observer[facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 observer[facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 observer[facing=north,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~1 ~ observer[facing=up,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~-1 ~ observer[facing=down,powered=true] run function bone_msd:redstone/set_power