execute positioned ~ ~ ~ run function bone_msd:redstone/check/button
execute positioned ~ ~ ~ run function bone_msd:redstone/check/comparator
execute positioned ~ ~ ~ run function bone_msd:redstone/check/lever
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/lightning_rod
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/observer
execute positioned ~ ~ ~ run function bone_msd:redstone/check/redstone_dust
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/repeater
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/sculk_sensor
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/tripwire_hook
#execute positioned ~ ~ ~ run function bone_msd:redstone/check/weighted_pressure_plates

execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:redstone_components[facing=up,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:redstone_components[facing=down,powered=true] run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:redstone_components[facing=east,powered=true] run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:redstone_components[facing=west,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:redstone_components[facing=south,powered=true] run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:redstone_components[facing=north,powered=true] run function bone_msd:redstone/set_power

execute positioned ~ ~1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~-1 ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~-1 ~ ~ if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
execute positioned ~ ~ ~-1 if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] unless block ~ ~ ~ minecraft:redstone_wire run function bone_msd:redstone/set_power
