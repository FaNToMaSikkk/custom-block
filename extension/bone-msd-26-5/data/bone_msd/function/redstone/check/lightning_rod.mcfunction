execute if block ~1 ~ ~ lightning_rod[facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ lightning_rod[facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 lightning_rod[facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 lightning_rod[facing=north,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~1 ~ lightning_rod[facing=up,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~-1 ~ lightning_rod[facing=down,powered=true] run function bone_msd:redstone/set_power