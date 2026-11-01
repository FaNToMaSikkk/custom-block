data remove storage bone_msd:block_engine BlockData
execute unless data entity @s SelectedItem if data entity @s equipment.offhand.components."minecraft:custom_data".bone_cb run data modify storage bone_msd:block_engine BlockData set from entity @s equipment.offhand.components."minecraft:custom_data".bone_cb
execute if data entity @s SelectedItem.components."minecraft:custom_data".bone_cb run data modify storage bone_msd:block_engine BlockData set from entity @s SelectedItem.components."minecraft:custom_data".bone_cb

data modify storage bone_msd:block_engine BlockData.base_block set from storage bone_msd:block_engine BlockData.place_information.base_block

data modify storage bone_msd:block_engine BlockData.entity_id set from storage bone_msd:block_engine BlockData.place_information.block_entity.id
data modify storage bone_msd:block_engine BlockData.entity_data set from storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data
data modify storage bone_msd:block_engine BlockData.loot_table set from storage bone_msd:block_engine BlockData.place_information.block_entity.loot_table

