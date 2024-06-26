# This function is run by `main` which ensures thot `@s` is a minecart

# SoulCart[XZ]GameSpeed is the base speed of the minecart according to the
# built-in game logic. SoulCartSpeed is the increased speed that this
# datapack accelerates the cart to.

# Capture current minecart speed. Scoreboards hold integers, while motion vector
# components are doubles. So we use the `scale` option to multiply the speed by
# 100 to get an integer approximation.
execute store result score @s SoulCartXGameSpeed run data get entity @s Motion[0] 100
execute store result score @s SoulCartZGameSpeed run data get entity @s Motion[2] 100

# Carts need to get up to speed before being accelerated by soul soil. Check if
# the cart is over the starting speed threshold, and record direction.
#
# Directions:
# - 0 East
# - 1 West
# - 2 South
# - 3 North
# - -1 not accelerated
scoreboard players set @s SoulCartDirection -1
execute if score @s SoulCartXGameSpeed matches 90.. run scoreboard players set @s SoulCartDirection 0
execute if score @s SoulCartXGameSpeed matches ..-90 run scoreboard players set @s SoulCartDirection 1
execute if score @s SoulCartZGameSpeed matches 90.. run scoreboard players set @s SoulCartDirection 2
execute if score @s SoulCartZGameSpeed matches ..-90 run scoreboard players set @s SoulCartDirection 3

# (I'd line these clauses up, but commands actually fail to parse if there are
# multiple spaces between tokens.)

# Set `SoulCartOnRails` - this line requires `SoulCartDirection` to be set
function soulcart:check_on_rails

# Conditions are met for high-speed acceleration if the cart's base speed is
# over the threshold (indicated by `SoulCartDirection`), on straight, level
# track (indicated by `SoulCartOnRails`), there is a player in the cart, and the
# cart is over soul soil.
scoreboard players set @s SoulCartAccelerating 0
execute if score @s SoulCartDirection matches 0.. if score @s SoulCartOnRails matches 1 if entity @p[distance=..1] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s SoulCartAccelerating 1

# Initialize SoulCartSpeed if it is not already set
execute unless score @s SoulCartSpeed matches 90.. run scoreboard players set @s SoulCartSpeed 90

# Prevent game from slowing cart while in high-speed mode
execute if score @s SoulCartAccelerating matches 1 if score @s SoulCartDirection matches 0 run data modify entity @s Motion[0] set value 1.0
execute if score @s SoulCartAccelerating matches 1 if score @s SoulCartDirection matches 1 run data modify entity @s Motion[0] set value -1.0
execute if score @s SoulCartAccelerating matches 1 if score @s SoulCartDirection matches 2 run data modify entity @s Motion[2] set value 1.0
execute if score @s SoulCartAccelerating matches 1 if score @s SoulCartDirection matches 3 run data modify entity @s Motion[2] set value -1.0

# This is the call that actually moves the minecart faster than normal. Run it
# even if `SoulCartAccelerating` is not set to conserve momentum when coming off
# soul soil.
execute if score @s SoulCartDirection matches 0 facing ~1 ~ ~ run function soulcart:move
execute if score @s SoulCartDirection matches 1 facing ~-1 ~ ~ run function soulcart:move
execute if score @s SoulCartDirection matches 2 facing ~ ~ ~1 run function soulcart:move
execute if score @s SoulCartDirection matches 3 facing ~ ~ ~-1 run function soulcart:move

# Accelerate while high-speed conditions are met
execute if score @s SoulCartAccelerating matches 1 run scoreboard players add @s SoulCartSpeed 1

# Decelerate while high-speed conditions are not met. With a value of 50 it
# takes 8 blocks to safely decelerate from full speed.
execute unless score @s SoulCartAccelerating matches 1 run scoreboard players remove @s SoulCartSpeed 50

# Cap at maximum speed
execute if score @s SoulCartSpeed matches 250.. run scoreboard players set @s SoulCartSpeed 250

# After teleporting check for derailement, and apply consequences. Derailment
# can occur when encountering a corner, teleporting past a corner, coming to the
# end of the track, hitting a block at the end of the track, or going up or down
# a slope.
#
# (Adding `at @s` updates the execute position to the minecart's new position
# after teleport.)
execute at @s run function soulcart:check_on_rails
execute at @s if score @s SoulCartSpeed matches 100.. if score @s SoulCartOnRails matches 0 run function soulcart:schedule_explosion
