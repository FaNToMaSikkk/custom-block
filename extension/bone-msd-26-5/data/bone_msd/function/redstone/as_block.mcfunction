scoreboard players set @s[scores={quasi=0}] powered 0
scoreboard players set @s[scores={quasi=0}] power 0
scoreboard players set @s quasi 0
execute at @s run function bone_msd:redstone/check_area
execute unless score @s impulse = @s impulse run scoreboard players set @s impulse 0
execute if score @s powered matches 1 if score @s impulse matches 1 run scoreboard players set @s impulse 2
execute if score @s powered matches 1 if score @s impulse matches 0 run scoreboard players set @s impulse 1
execute if score @s powered matches 0 if score @s impulse matches 2 run scoreboard players set @s impulse 0
execute if score @s powered matches 0 if score @s impulse matches 1 run scoreboard players set @s impulse 0
