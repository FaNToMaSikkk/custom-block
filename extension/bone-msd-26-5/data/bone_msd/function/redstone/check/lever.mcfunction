execute if block ~1 ~ ~ lever[face=wall,facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ lever[face=wall,facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 lever[face=wall,facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 lever[face=wall,facing=north,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~1 ~ lever[face=floor,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~-1 ~ lever[face=ceiling,powered=true] run function bone_msd:redstone/set_power