#executed AS arrow, AT firing player

#Kill any other hook arrows the player has fired
execute as @e[type=arrow,tag=GrapnelArrow] if score @s grapnelPlayerId = @p grapnelPlayerId run kill @s

#Tag the new arrow, update its properties, and assign it a player id
data merge entity @s {Tags: ["GrapnelArrow"], NoGravity: 1b, Color: -1, damage: 0d, pickup: 0b}
scoreboard players operation @s grapnelPlayerId = @p grapnelPlayerId
