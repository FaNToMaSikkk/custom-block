# Повторяет custom_blocks:shaped/placed, но берёт предмет из сундука, а «взгляд» — вниз под 45° на юг
$setblock $(x) 64 3 chest
$loot insert $(x) 64 3 loot custom_blocks:blocks/$(id)/give
data remove storage custom_blocks:shaped Place
$data modify storage custom_blocks:shaped Place.item set from block $(x) 64 3 Items[0]
data remove storage custom_blocks:shaped Place.item.Slot
data modify storage custom_blocks:shaped Place merge from storage custom_blocks:shaped Place.item.components."minecraft:custom_data".bone_cs
scoreboard players set #dist cbs 0
$execute positioned $(x).5 $(y) -0.5 rotated 0 45 run function custom_blocks:shaped/ray with storage custom_blocks:shaped Place
