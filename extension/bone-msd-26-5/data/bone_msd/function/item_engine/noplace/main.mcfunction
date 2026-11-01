
function bone_msd:item_engine/noplace/common
execute if data entity @s[tag=!Holding, gamemode=survival] {SelectedItem:{components:{"minecraft:can_break":{blocks:"#bone_msd:item_engine/noplace"}}}} run function bone_msd:item_engine/noplace/holding
execute if data entity @s[tag=!Holding, gamemode=survival] {equipment:{offhand:{components:{"minecraft:can_break":{blocks:"#bone_msd:item_engine/noplace"}}}}} run function bone_msd:item_engine/noplace/holding
execute unless data entity @s[tag=Holding, gamemode=adventure] {SelectedItem:{components:{"minecraft:can_break":{blocks:"#bone_msd:item_engine/noplace"}}}} unless data entity @s[tag=Holding, gamemode=adventure] {equipment:{offhand:{components:{"minecraft:can_break":{blocks:"#bone_msd:item_engine/noplace"}}}}} run function bone_msd:item_engine/noplace/not_holding
tag @s[gamemode=creative] remove Holding
