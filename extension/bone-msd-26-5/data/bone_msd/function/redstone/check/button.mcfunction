execute if block ~1 ~ ~ #minecraft:buttons[face=wall,facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ #minecraft:buttons[face=wall,facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 #minecraft:buttons[face=wall,facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 #minecraft:buttons[face=wall,facing=north,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~1 ~ #minecraft:buttons[face=floor,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~-1 ~ #minecraft:buttons[face=ceiling,powered=true] run function bone_msd:redstone/set_power