data remove storage bone_msd:inventory_engine ItemData

$execute if items entity @s $(location) painting run data modify storage bone_msd:inventory_engine ItemData.painting_data set from entity @s $(slot)
data modify storage bone_msd:inventory_engine ItemData.painting_variant set from storage bone_msd:inventory_engine ItemData.painting_data.components."minecraft:painting/variant"
data modify storage bone_msd:inventory_engine ItemData.count set from storage bone_msd:inventory_engine ItemData.painting_data.count
$data modify storage bone_msd:inventory_engine ItemData.location set value $(location)
function bone_msd:inventory_engine/update_slot with storage bone_msd:inventory_engine ItemData
