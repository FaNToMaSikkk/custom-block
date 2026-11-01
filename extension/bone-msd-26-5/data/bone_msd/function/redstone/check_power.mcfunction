
execute if score @s power matches ..0 if block ~ ~ ~ #minecraft:leveled_components[power=1] run scoreboard players set @s power 1
execute if score @s power matches ..1 if block ~ ~ ~ #minecraft:leveled_components[power=2] run scoreboard players set @s power 2
execute if score @s power matches ..2 if block ~ ~ ~ #minecraft:leveled_components[power=3] run scoreboard players set @s power 3
execute if score @s power matches ..3 if block ~ ~ ~ #minecraft:leveled_components[power=4] run scoreboard players set @s power 4
execute if score @s power matches ..4 if block ~ ~ ~ #minecraft:leveled_components[power=5] run scoreboard players set @s power 5
execute if score @s power matches ..5 if block ~ ~ ~ #minecraft:leveled_components[power=6] run scoreboard players set @s power 6
execute if score @s power matches ..6 if block ~ ~ ~ #minecraft:leveled_components[power=7] run scoreboard players set @s power 7
execute if score @s power matches ..7 if block ~ ~ ~ #minecraft:leveled_components[power=8] run scoreboard players set @s power 8
execute if score @s power matches ..8 if block ~ ~ ~ #minecraft:leveled_components[power=9] run scoreboard players set @s power 9
execute if score @s power matches ..9 if block ~ ~ ~ #minecraft:leveled_components[power=10] run scoreboard players set @s power 10
execute if score @s power matches ..10 if block ~ ~ ~ #minecraft:leveled_components[power=11] run scoreboard players set @s power 11
execute if score @s power matches ..11 if block ~ ~ ~ #minecraft:leveled_components[power=12] run scoreboard players set @s power 12
execute if score @s power matches ..12 if block ~ ~ ~ #minecraft:leveled_components[power=13] run scoreboard players set @s power 13
execute if score @s power matches ..13 if block ~ ~ ~ #minecraft:leveled_components[power=14] run scoreboard players set @s power 14
execute if score @s power matches ..14 if block ~ ~ ~ #minecraft:leveled_components[power=15] run scoreboard players set @s power 15

execute unless score @s power matches 1.. if block ~ ~ ~ minecraft:daylight_detector[power=0] run scoreboard players set @s power 0