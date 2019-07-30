execute store success score $HasPlayerId grapnelTemp run scoreboard players get @s grapnelPlayerId
execute if score $HasPlayerId grapnelTemp matches 0 run scoreboard players operation @s grapnelPlayerId = $NextId grapnelPlayerId
execute if score $HasPlayerId grapnelTemp matches 0 run scoreboard players add $NextId grapnelPlayerId 1
execute if score $HasPlayerId grapnelTemp matches 0 run give @s crossbow{Grapnel: 1b, HideFlags: 4b, Unbreakable: 1b, display: {Name: '{"text": "Grappling Hook Launcher", "italic": false}'}, ChargedProjectiles: [{id: "minecraft:arrow", Count: 1b, tag:{display: {Name: '{"text": "Grapnel", "italic": false}'}}}], Charged: 1b}
tellraw @s "If you lose your Grappling Hook Launcher, you can \"/trigger grapnel\" to get another one!"
