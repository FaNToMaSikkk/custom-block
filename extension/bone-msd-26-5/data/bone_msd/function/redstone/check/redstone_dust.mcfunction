execute positioned ~1 ~ ~ if block ~ ~ ~ redstone_wire[west=side] unless block ~ ~ ~ redstone_wire[power=0] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ redstone_wire[east=side] unless block ~ ~ ~ redstone_wire[power=0] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ redstone_wire[north=side] unless block ~ ~ ~ redstone_wire[power=0] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ redstone_wire[south=side] unless block ~ ~ ~ redstone_wire[power=0] run function bone_msd:redstone/set_power
execute positioned ~ ~1 ~ if block ~ ~ ~ redstone_wire unless block ~ ~ ~ redstone_wire[power=0] run function bone_msd:redstone/set_power