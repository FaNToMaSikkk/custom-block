$execute unless block ~ ~ ~ $(base_block) unless block ~ ~ ~ barrier unless data entity @s data.block_data.loot_table run function bone_msd:block_engine/breaking/break with entity @s data.block_data
$execute unless block ~ ~ ~ $(base_block) unless block ~ ~ ~ barrier if data entity @s data.block_data.loot_table run function bone_msd:block_engine/breaking/custom_break with entity @s data.block_data
#$execute unless block ~ ~ ~ $(base_block) unless block ~ ~ ~ barrier if data entity @s data.block_data.loot_table run kill @n[tag=bone_msd_display,distance=..0.5]
