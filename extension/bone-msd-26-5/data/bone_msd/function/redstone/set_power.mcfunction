scoreboard players set @s powered 1
#scoreboard players set @s power 0
execute if block ~ ~ ~ #minecraft:leveled_components unless block ~ ~ ~ #minecraft:leveled_components[power=0] run function bone_msd:redstone/check_power
execute unless block ~ ~ ~ #minecraft:leveled_components run scoreboard players set @s power 15