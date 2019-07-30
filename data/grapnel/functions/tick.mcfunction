#Refill the hook with ammo (use replaceitem instead of 'data modify ... merge' to avoid synchronization issues between server and client)
execute as @a[nbt={SelectedItem:{id:"minecraft:crossbow",tag:{Grapnel:1b}}}] run replaceitem entity @s weapon.mainhand crossbow{Grapnel: 1b, HideFlags: 4b, Unbreakable: 1b, display: {Name: '{"text": "Grappling Hook Launcher", "italic": false}'}, ChargedProjectiles: [{id: "minecraft:arrow", Count: 1b, tag:{display: {Name: '{"text": "Grapnel", "italic": false}'}}}], Charged: 1b}
execute as @a[nbt={Inventory:[{Slot:-106b,id:"minecraft:crossbow",tag:{Grapnel:1b}}]}] run replaceitem entity @s weapon.offhand crossbow{Grapnel: 1b, HideFlags: 4b, Unbreakable: 1b, display: {Name: '{"text": "Grappling Hook Launcher", "italic": false}'}, ChargedProjectiles: [{id: "minecraft:arrow", Count: 1b, tag:{display: {Name: '{"text": "Grapnel", "italic": false}'}}}], Charged: 1b}

#Process anybody that used /trigger grapnel
execute as @a[scores={grapnel=1..}] run give @s crossbow{Grapnel: 1b, HideFlags: 4b, Unbreakable: 1b, display: {Name: '{"text": "Grappling Hook Launcher", "italic": false}'}, ChargedProjectiles: [{id: "minecraft:arrow", Count: 1b, tag:{display: {Name: '{"text": "Grapnel", "italic": false}'}}}], Charged: 1b}
scoreboard players enable @a grapnel
scoreboard players set @a grapnel 0

#Process all 'hook arrows' that have landed somewhere
execute as @e[type=arrow,tag=GrapnelArrow,nbt={inGround:1b}] at @s run function grapnel:grapnel_set

#Kill any 'hook arrows' that are more than 33 blocks from their player
execute as @a at @s at @e[type=arrow,tag=GrapnelArrow,distance=33..] if score @s grapnelPlayerId = @e[type=arrow,tag=GrapnelArrow,distance=0,limit=1] grapnelPlayerId run kill @e[type=arrow,tag=GrapnelArrow,distance=0]

#Update mover positions towards their anchors
execute as @e[type=armor_stand,tag=GrapnelMover,scores={grapnelCounter=8..}] at @s run function grapnel:update_mover_collision
execute as @e[type=armor_stand,tag=GrapnelMover,scores={grapnelCounter=..7}] at @s run function grapnel:update_mover
execute at @e[type=armor_stand,tag=GrapnelMover] as @e[type=area_effect_cloud,tag=GrapnelAnchor,distance=..0.5] if score @s grapnelPlayerId = @e[type=armor_stand,tag=GrapnelMover,distance=0,limit=1] grapnelPlayerId run tag @e[type=armor_stand,tag=GrapnelMover,distance=0,limit=1] add GrapnelMoverDone

#Teleport players to their associated movers
execute at @a as @e[type=armor_stand,tag=GrapnelMover] if score @s grapnelPlayerId = @p grapnelPlayerId at @s run tp @p ^ ^ ^-0.25

#Add levitate to players with movers (level -1 for active movers just so they don't fall, level 17 for done movers to 'pop' them up) (AEC's apply effects at Age%5=0)
execute at @e[type=armor_stand,tag=GrapnelMover,tag=!GrapnelMoverDone] at @p run summon area_effect_cloud ~ ~ ~ {Radius:0f,Duration:6,Age:4,Effects:[{Id:25b,Amplifier:255b,Duration:5,ShowParticles:0b}]}
execute at @e[type=armor_stand,tag=GrapnelMoverDone] at @p run summon area_effect_cloud ~ ~ ~ {Radius:0f,Duration:6,Age:4,Effects:[{Id:25b,Amplifier:17b,Duration:5,ShowParticles:0b}]}

#Count until time for featherfall after 'popping' the player up
execute at @e[type=armor_stand,tag=GrapnelMoverDone] as @p run scoreboard players set @s grapnelCounter 6
execute as @a[scores={grapnelCounter=1..}] run scoreboard players remove @s grapnelCounter 1
execute as @a[scores={grapnelCounter=1}] at @s run summon area_effect_cloud ~ ~ ~ {Radius:0f,Duration:6,Age:4,Effects:[{Id:28b,Duration:60,ShowParticles:0b}]}

#Kill done movers and associated anchors
execute at @e[type=armor_stand,tag=GrapnelMoverDone] as @e[type=area_effect_cloud,tag=GrapnelAnchor] if score @s grapnelPlayerId = @e[type=armor_stand,tag=GrapnelMoverDone,distance=0,limit=1] grapnelPlayerId run kill @s
kill @e[type=armor_stand,tag=GrapnelMoverDone]
