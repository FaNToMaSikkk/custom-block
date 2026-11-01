# Повторяет bone_msd:block_engine/placing/store_block_info, но берёт bone_cb из сундука, а не из руки игрока
$setblock $(x) 64 0 chest
$loot insert $(x) 64 0 loot custom_blocks:blocks/$(id)/give
data remove storage bone_msd:block_engine BlockData
$data modify storage bone_msd:block_engine BlockData set from block $(x) 64 0 Items[0].components."minecraft:custom_data".bone_cb
data modify storage bone_msd:block_engine BlockData.base_block set from storage bone_msd:block_engine BlockData.place_information.base_block
data modify storage bone_msd:block_engine BlockData.entity_id set from storage bone_msd:block_engine BlockData.place_information.block_entity.id
data modify storage bone_msd:block_engine BlockData.entity_data set from storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data
data modify storage bone_msd:block_engine BlockData.loot_table set from storage bone_msd:block_engine BlockData.place_information.block_entity.loot_table
$setblock $(x) 65 0 barrier
# как placed_barrier: луч «взгляда» на юг из соседней клетки находит поставленный барьер
scoreboard players set place_dist Check 0
$execute positioned $(x).5 65.5 -0.5 rotated 0 0 run function bone_msd:block_engine/placing/find_barrier
$execute if block $(x) 65 0 command_block run say T2 OK $(id): barrier -> command_block
# установку делает сам command_block на следующем тике
