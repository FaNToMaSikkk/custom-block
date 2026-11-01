tag @s[tag=Tick1] add Tick2
tag @s[tag=Tick2] remove Tick1
execute as @s[tag=Tick2] run gamerule send_command_feedback true
execute as @s[tag=Tick2] run tag @s remove Tick2

tag @s[tag=CommBlock] add Tick1
tag @s[tag=Tick1] remove CommBlock
