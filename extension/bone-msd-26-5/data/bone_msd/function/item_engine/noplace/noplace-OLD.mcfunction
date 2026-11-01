gamemode survival @s[tag=survival,gamemode=adventure]
tag @s[tag=survival] remove survival
tag @s[nbt={SelectedItem:{tag:{NoPlace:1b}}},gamemode=survival] add survival
execute as @s[tag=survival] run gamerule sendCommandFeedback false
gamemode adventure @s[tag=survival]
execute unless entity @a[tag=survival] as @s[tag=!survival] run gamerule sendCommandFeedback true
