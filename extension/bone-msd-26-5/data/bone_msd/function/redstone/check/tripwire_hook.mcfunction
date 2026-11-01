execute if block ~1 ~ ~ tripwire_hook[facing=east,powered=true] run function bone_msd:redstone/set_power
execute if block ~-1 ~ ~ tripwire_hook[facing=west,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~1 tripwire_hook[facing=south,powered=true] run function bone_msd:redstone/set_power
execute if block ~ ~ ~-1 tripwire_hook[facing=north,powered=true] run function bone_msd:redstone/set_power