#data remove storage bone_msd:inventory_engine ItemData

$loot replace entity @s $(location) loot $(painting_variant)/give
$item modify entity @s $(location) {type:"minecraft:set_count",count:$(count)}
