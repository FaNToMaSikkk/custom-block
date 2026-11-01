execute if block 2 65 0 waxed_oxidized_cut_copper_slab[type=double,waterlogged=false] run say T3 OK engraved_copper placed
# 4. дроп кастомного блока
setblock 4 64 2 chest
loot insert 4 64 2 mine 0 65 0 minecraft:stick
execute if data block 4 64 2 Items[{id:"minecraft:barrier",components:{"minecraft:painting/variant":"custom_blocks:blocks/split_oak"}}] run say T4 OK split_oak drops itself
data get block 4 64 2 Items
setblock 5 64 2 chest
loot insert 5 64 2 mine 2 65 0 minecraft:stone_pickaxe
execute if data block 5 64 2 Items[{id:"minecraft:barrier",components:{"minecraft:painting/variant":"custom_blocks:blocks/engraved_copper"}}] run say T4 OK copper drops itself with pickaxe
# 5. обычная плита дропает плиту
setblock 6 65 0 pale_oak_slab
setblock 6 64 2 chest
loot insert 6 64 2 mine 6 65 0 minecraft:stick
execute if data block 6 64 2 Items[{id:"minecraft:pale_oak_slab",count:1}] run say T5 OK single slab drops 1 slab
data get block 6 64 2 Items
# 6. макрос inventory_engine/update_slot (картина -> предмет блока)
summon armor_stand 8 65 0 {Tags:["cbt"],equipment:{mainhand:{id:"minecraft:painting",count:7}}}
execute as @e[tag=cbt,limit=1] run function bone_msd:inventory_engine/update_slot {location:"weapon.mainhand",painting_variant:"custom_blocks:blocks/carved_oak",count:7}
execute as @e[tag=cbt,limit=1] if items entity @s weapon.mainhand minecraft:barrier[minecraft:painting/variant="custom_blocks:blocks/carved_oak"] run say T6 OK painting converted
data get entity @e[tag=cbt,limit=1] equipment.mainhand
# 7. реестр картин и тег placeable
# 8-13. плиты и ступеньки через item_display
schedule function cbtest:shaped1 1t
