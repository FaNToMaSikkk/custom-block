# Патч Custom-Block: шаг луча 0.1 блока, до 8 блоков (дальность установки в креативе — 5).
execute if block ~ ~ ~ minecraft:barrier run return run setblock ~ ~ ~ minecraft:command_block{auto:1b,Command:"function bone_msd:block_engine/placing/parse_custom_json"}
scoreboard players add place_dist Check 1
execute if score place_dist Check matches ..80 positioned ^ ^ ^0.1 run function bone_msd:block_engine/placing/find_barrier
