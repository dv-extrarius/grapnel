#Store the motion from the previous execution in the nbt tags MotionX/Y/Z
execute as @s[tag=!GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.MotionX set from entity @s Motion[0]
execute as @s[tag=!GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.MotionY set from entity @s Motion[1]
execute as @s[tag=!GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.MotionZ set from entity @s Motion[2]

#Update the motion of the mover
function grapnel:update_mover

#For new movers, store the desired initial motion in the nbt tags FirstMotionX/Y/Z
execute as @s[tag=GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.FirstMotionX set from entity @s Motion[0]
execute as @s[tag=GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.FirstMotionY set from entity @s Motion[1]
execute as @s[tag=GrapnelNewMover] run data modify entity @s ArmorItems[0].tag.FirstMotionZ set from entity @s Motion[2]
tag @s remove GrapnelNewMover

#Test whether the mover hit an obstacle (two lines for Y are to deal with water)
execute as @s[nbt={ArmorItems:[{tag:{MotionX:0.0d}},{},{},{}]},nbt=!{ArmorItems:[{tag:{FirstMotionX:0.0d}},{},{},{}]}] run tag @s add GrapnelMoverDone
execute as @s[nbt={ArmorItems:[{tag:{MotionY:-0.0784000015258789d}},{},{},{}]},nbt=!{ArmorItems:[{tag:{FirstMotionY:0.0d}},{},{},{}]}] run tag @s add GrapnelMoverDone
execute as @s[nbt={ArmorItems:[{tag:{MotionY:-0.005d}},{},{},{}]},nbt=!{ArmorItems:[{tag:{FirstMotionY:-0.005d}},{},{},{}]}] run tag @s add GrapnelMoverDone
execute as @s[nbt={ArmorItems:[{tag:{MotionZ:0.0d}},{},{},{}]},nbt=!{ArmorItems:[{tag:{FirstMotionZ:0.0d}},{},{},{}]}] run tag @s add GrapnelMoverDone
