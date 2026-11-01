#execute positioned ~ ~ ~ run function bone_msd:redstone/check_quasi
execute positioned ~ ~ ~ run function bone_msd:redstone/check_direct

execute positioned ~ ~ ~ run function bone_msd:redstone/check_block
execute positioned ~1 ~ ~ unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block
execute positioned ~-1 ~ ~ unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block
execute positioned ~ ~ ~1 unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block
execute positioned ~ ~ ~-1 unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block
execute positioned ~ ~1 ~ unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block
execute positioned ~ ~-1 ~ unless block ~ ~ ~ #minecraft:transparent run function bone_msd:redstone/check_block

execute positioned ~1 ~ ~ if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block
execute positioned ~-1 ~ ~ if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block
execute positioned ~ ~ ~1 if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block
execute positioned ~ ~ ~-1 if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block
execute positioned ~ ~1 ~ if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block
execute positioned ~ ~-1 ~ if block ~ ~ ~ minecraft:target run function bone_msd:redstone/check_block