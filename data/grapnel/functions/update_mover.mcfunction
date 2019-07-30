#Get the current position into the PosX/Y/Z scoreboard variables
execute store result score PosX grapnelTemp run data get entity @s Pos[0] 100
execute store result score PosY grapnelTemp run data get entity @s Pos[1] 10000
execute store result score PosZ grapnelTemp run data get entity @s Pos[2] 100

#Get the position 1 unit forward into the ForwardX/Y/Z scoreboard variables
execute as @e[type=area_effect_cloud,tag=GrapnelAnchor] if score @s grapnelPlayerId = @e[type=armor_stand,tag=GrapnelMover,distance=0,limit=1] grapnelPlayerId facing entity @s feet run summon area_effect_cloud ^ ^ ^1.0 {Duration:1,Radius:0f,Tags:["GrapnelAnchorPos"]}
execute store result score ForwardX grapnelTemp run data get entity @e[type=area_effect_cloud,tag=GrapnelAnchorPos,limit=1] Pos[0] 100
execute store result score ForwardY grapnelTemp run data get entity @e[type=area_effect_cloud,tag=GrapnelAnchorPos,limit=1] Pos[1] 10000
execute store result score ForwardZ grapnelTemp run data get entity @e[type=area_effect_cloud,tag=GrapnelAnchorPos,limit=1] Pos[2] 100
kill @e[type=area_effect_cloud,tag=GrapnelAnchorPos]

#Adjust ForwardX/Y/Z to be just 1 unit forward
scoreboard players operation ForwardX grapnelTemp -= PosX grapnelTemp
scoreboard players operation ForwardY grapnelTemp -= PosY grapnelTemp
scoreboard players operation ForwardZ grapnelTemp -= PosZ grapnelTemp

#Store the ForwardX/Y/Z into the Motion nbt
execute store result entity @s Motion[0] double 0.01 run scoreboard players get ForwardX grapnelTemp
execute store result entity @s Motion[1] double 0.0001 run scoreboard players get ForwardY grapnelTemp
execute store result entity @s Motion[2] double 0.01 run scoreboard players get ForwardZ grapnelTemp

#Increment the counter for this mover, which will eventually trigger it to track collisions
scoreboard players add @s grapnelCounter 1
