#Inventory Engine
advancement revoke @a[tag=UpdateInventory2] only bone_msd:inventory_engine/update_inventory
tag @a[tag=UpdateInventory2] remove UpdateInventory
tag @a[tag=UpdateInventory2] remove UpdateInventory2
tag @a[tag=UpdateInventory] add UpdateInventory2
execute as @a[tag=UpdateInventory] run function bone_msd:inventory_engine/update_inventory

#Block Engine
function bone_msd:block_engine/block_functionality/main
execute as @e[tag=bone_msd_block] at @s run function bone_msd:block_engine/breaking/main with entity @s data.block_data

#Item Engine
function bone_msd:item_engine/main

#Custom Redstone
execute as @e[tag=redstone_powered] at @s run function bone_msd:redstone/as_block

#Kill Leftover Entities
kill @e[type=marker,tag=raycast_hit]
