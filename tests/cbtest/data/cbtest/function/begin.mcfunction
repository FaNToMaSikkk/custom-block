setblock 8 70 8 air
fill 0 63 -1 15 70 3 air
fill 0 62 -1 15 62 3 stone
# 1. предмет блока
setblock 0 64 2 chest
loot insert 0 64 2 loot custom_blocks:blocks/split_oak/give
execute if data block 0 64 2 Items[{id:"minecraft:barrier"}].components."minecraft:custom_data".bone_cb run say T1 OK give item has bone_cb
data get block 0 64 2 Items[0]
# 2-3. установка; рядом обычный барьер, который движок трогать не должен (7)
setblock 1 65 0 barrier
function cbtest:sim_place {x:0,id:"split_oak"}
schedule function cbtest:step2 10t
say WAIT for command blocks
