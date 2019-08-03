advancement revoke @s only grapnel:shot_grapnel

#Update the shot arrow with a tag and other data
execute at @s as @e[type=arrow,tag=!GrapnelArrow,limit=1,sort=nearest] run function grapnel:new_grapnel
