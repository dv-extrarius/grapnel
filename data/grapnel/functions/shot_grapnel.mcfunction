advancement revoke @s only grapnel:shot_hook

#Update the shot arrow with a tag and other data
execute at @s as @e[type=arrow,tag=!HookArrow,limit=1,sort=nearest] run function grapnel:new_grapnel
