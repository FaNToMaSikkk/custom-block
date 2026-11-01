execute as @e[type=item_display,tag=cbs.stairs] if score @s cbs matches 38 if data entity @s item.components."minecraft:custom_model_data"{strings:["outer"]} run say T10 OK stairs model updated on shape change
execute store result score #n cbtest if entity @e[type=item_display,tag=cbs.slab,tag=cbs.dbl]
execute if score #n cbtest matches 2 run say T11 OK double slab has two lifted displays
# 12-13. поломка двойной плиты из двух кастомных половин
setblock 10 65 0 air destroy
schedule function cbtest:shaped3 3t
