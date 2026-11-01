execute if data storage bone_msd:block_engine {BlockData:{use_place_function:1b}} unless data storage bone_msd:block_engine BlockData.place_function_location run function bone_msd:block_engine/placing/default_place_command_location with storage bone_msd:block_engine BlockData
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:1b}} if data storage bone_msd:block_engine BlockData.place_function_location run function bone_msd:block_engine/placing/custom_place_command_location with storage bone_msd:block_engine BlockData

#No Entity
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:0b}} unless data storage bone_msd:block_engine BlockData.place_information.block_entity run function bone_msd:block_engine/placing/direct_no_entity with storage bone_msd:block_engine BlockData

#If Entity, Data, And Loot Table
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:0b}} if data storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data if data storage bone_msd:block_engine BlockData.place_information.block_entity.loot_table run function bone_msd:block_engine/placing/direct_entity_data with storage bone_msd:block_engine BlockData

#If Entity and loot_table, but no data
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:0b}} if data storage bone_msd:block_engine BlockData.place_information.block_entity unless data storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data if data storage bone_msd:block_engine BlockData.loot_table run function bone_msd:block_engine/placing/direct_entity_no_data with storage bone_msd:block_engine BlockData

#If entity and data, but no loot table
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:0b}} if data storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data unless data storage bone_msd:block_engine BlockData.loot_table run function bone_msd:block_engine/placing/direct_entity_data_no_loot_table with storage bone_msd:block_engine BlockData

#If Entity, but no data or loot table
execute if data storage bone_msd:block_engine {BlockData:{use_place_function:0b}} if data storage bone_msd:block_engine BlockData.place_information.block_entity unless data storage bone_msd:block_engine BlockData.place_information.block_entity.entity_data unless data storage bone_msd:block_engine BlockData.loot_table run function bone_msd:block_engine/placing/direct_entity_no_data_or_loot_table with storage bone_msd:block_engine BlockData


#execute unless data storage bone_msd:block_engine BlockData.use_custom_place_command_location run function bone_msd:block_engine/placing/default_place_command_location with storage bone_msd:block_engine BlockData

