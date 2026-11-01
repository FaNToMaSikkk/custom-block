# 8. нижняя плита
setblock 10 65 0 oak_slab[type=bottom]
function cbtest:sim_shaped {x:10,id:"split_oak_slab",y:"65.9"}
execute positioned 10.5 65.5 0.5 if entity @e[type=item_display,tag=cbs.slab,tag=cbs.bottom,tag=cbs.m.wood,distance=..0.01] run say T8 OK slab display spawned
# 9. ступеньки: модель по состоянию (south,bottom,straight = 10)
setblock 12 65 0 oak_stairs[facing=south,half=bottom]
function cbtest:sim_shaped {x:12,id:"split_oak_stairs",y:"65.9"}
execute positioned 12.5 65.5 0.5 as @e[type=item_display,tag=cbs.stairs,distance=..0.01] if score @s cbs matches 10 run say T9 OK stairs display follows state
data get entity @e[type=item_display,tag=cbs.stairs,limit=1]
# вторая плита в ту же клетку, сверху; ступеньки меняют форму (east,top,outer_left = 38)
setblock 10 65 0 oak_slab[type=double]
function cbtest:sim_shaped {x:10,id:"split_oak_slab",y:"66.3"}
setblock 12 65 0 oak_stairs[facing=east,half=top,shape=outer_left]
schedule function cbtest:shaped2 3t
