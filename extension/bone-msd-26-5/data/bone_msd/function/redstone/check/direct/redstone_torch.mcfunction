execute positioned ~ ~-1 ~ if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power

execute positioned ~ ~-2 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~-1 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~-1 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~1 unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~-1 unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_torch[lit=true] run function bone_msd:redstone/set_power

