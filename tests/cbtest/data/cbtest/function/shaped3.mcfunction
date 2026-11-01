# сумма кастомных плит среди выпавших предметов и число обычных дубовых плит
scoreboard players set #m cbtest 0
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{bone_cs:{block_name:"split_oak_slab"}}}}}] store result score @s cbtest run data get entity @s Item.count
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{bone_cs:{block_name:"split_oak_slab"}}}}}] run scoreboard players operation #m cbtest += @s cbtest
scoreboard players set #plain cbtest 0
execute as @e[type=item,nbt={Item:{id:"minecraft:oak_slab"}}] unless data entity @s Item.components run scoreboard players add #plain cbtest 1
execute if score #plain cbtest matches 0 if score #m cbtest matches 2 run say T12 OK broken double slab drops 2 custom slabs, no oak slabs
execute unless entity @e[type=item_display,tag=cbs.slab] run say T13 OK slab displays removed
say TEST END
