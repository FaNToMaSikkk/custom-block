execute positioned ~ ~2 ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~1 ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=east] run function bone_msd:redstone/set_power
execute positioned ~-1 ~1 ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=west] run function bone_msd:redstone/set_power
execute positioned ~ ~1 ~1 if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=south] run function bone_msd:redstone/set_power
execute positioned ~ ~1 ~-1 if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=north] run function bone_msd:redstone/set_power

execute positioned ~ ~-1 ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~1 ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=east] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=west] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=south] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] unless block ~ ~ ~ minecraft:redstone_wall_torch[facing=north] run function bone_msd:redstone/set_power

execute positioned ~ ~-2 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~-1 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~-1 ~ unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~1 unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~-1 unless block ~ ~1 ~ #minecraft:transparent if block ~ ~ ~ minecraft:redstone_wall_torch[lit=true] run function bone_msd:redstone/set_power