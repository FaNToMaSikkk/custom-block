execute if block 0 65 0 pale_oak_slab[type=double,waterlogged=false] run say T3 OK split_oak placed by command block
execute if block 1 65 0 barrier run say T7 OK nearby vanilla barrier untouched
setblock 1 65 0 air
function cbtest:sim_place {x:2,id:"engraved_copper"}
schedule function cbtest:rest 10t
