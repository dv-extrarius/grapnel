#kill any previous anchor and mover
execute at @e[type=area_effect_cloud,tag=GrapnelAnchor] if score @s grapnelPlayerId = @e[type=area_effect_cloud,tag=GrapnelAnchor,distance=0,limit=1] grapnelPlayerId run kill @e[type=area_effect_cloud,tag=GrapnelAnchor,distance=0,limit=1]
execute as @a if score @s grapnelPlayerId = @e[type=arrow,tag=GrapnelArrow,nbt={inGround:1b},distance=0,limit=1] grapnelPlayerId at @s run kill @e[type=armor_stand,tag=GrapnelMover,limit=1,sort=nearest]

#summon a new anchor and set id
summon area_effect_cloud ~ ~ ~ {Duration:2147483647,Radius:0f,Tags:["GrapnelAnchor"]}
scoreboard players operation @e[type=area_effect_cloud,tag=GrapnelAnchor,distance=..0.01,limit=1,sort=nearest] grapnelPlayerId = @s grapnelPlayerId

#summon a new mover and set id, initialize counter, and make it face the anchor
execute at @a if score @p grapnelPlayerId = @s grapnelPlayerId run summon armor_stand ~ ~ ~ {Small:1b,Invulnerable:1b,Invisible:1b,Silent:1b,Tags:["GrapnelMover","GrapnelNewMover","GrapnelNewNew"],ArmorItems:[{id:"minecraft:dirt",Count:1b},{},{},{}]}
execute as @e[type=armor_stand,tag=GrapnelNewNew] at @s run scoreboard players operation @s grapnelPlayerId = @p grapnelPlayerId
execute as @e[type=armor_stand,tag=GrapnelNewNew] run scoreboard players set @s grapnelCounter 0
execute at @a if score @p grapnelPlayerId = @s grapnelPlayerId facing entity @s feet run tp @e[distance=..8,type=armor_stand,tag=GrapnelNewNew,limit=1,sort=nearest] ^ ^0.1 ^-0.1 facing entity @s
tag @e[type=armor_stand,tag=GrapnelNewNew] remove GrapnelNewNew

#get rid of the arrow
kill @s
