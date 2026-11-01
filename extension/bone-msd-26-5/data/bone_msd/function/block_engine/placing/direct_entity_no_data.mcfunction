$setblock ~ ~ ~ $(base_block)

tag @e add Old

$summon $(entity_id) ~ ~ ~
tag @n[tag=!Old] add bone_msd_block
$tag @n[tag=!Old] add $(block_name)
$data modify entity @n[tag=!Old] data.block_data.pack set value "$(pack)"
$data modify entity @n[tag=!Old] data.block_data.block_name set value "$(block_name)"
$data modify entity @n[tag=!Old] data.block_data.loot_table set value "$(loot_table)"
$data modify entity @n[tag=!Old] data.block_data.base_block set value "$(base_block)"

tag @e remove Old
