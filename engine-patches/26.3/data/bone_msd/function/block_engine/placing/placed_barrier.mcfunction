# Патч Custom-Block. Оригинал заменял командными блоками ВСЕ барьеры в кубе 15×15×15 вокруг игрока
# (fill_layer), поэтому рядом стоящие обычные барьеры превращались в копии ставящегося блока.
# Теперь заменяется только поставленный барьер: первый барьер на луче взгляда игрока.
# Обычные барьеры (без bone_cb) сюда не попадают: это отсекает условие match_tool в advancement placed_block.
function bone_msd:block_engine/placing/store_block_info
scoreboard players set place_dist Check 0
execute anchored eyes positioned ^ ^ ^ run function bone_msd:block_engine/placing/find_barrier
advancement revoke @s only bone_msd:block_engine/placed_block
