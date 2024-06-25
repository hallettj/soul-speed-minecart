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
execute if score @s SoulCartXGameSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=east_west] run scoreboard players set @s SoulCartDirection 0
execute if score @s SoulCartXGameSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=east_west] run scoreboard players set @s SoulCartDirection 1
execute if score @s SoulCartZGameSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=north_south] run scoreboard players set @s SoulCartDirection 2
execute if score @s SoulCartZGameSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=north_south] run scoreboard players set @s SoulCartDirection 3

# But wait, we don't meet the criteria for high speed if the minecart is not
# over soul soil, or does not have a player riding.
execute unless block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s SoulCartDirection -1
execute unless entity @p[distance=..1] run scoreboard players set @s SoulCartDirection -1

# Initialize SoulCartSpeed if it is not already set
execute unless score @s SoulCartSpeed matches 90.. run scoreboard players set @s SoulCartSpeed 90

# Prevent game from slowing cart while in high-speed mode
execute if score @s SoulCartDirection matches 0 run data modify entity @s Motion[0] set value 1.0
execute if score @s SoulCartDirection matches 1 run data modify entity @s Motion[0] set value -1.0
execute if score @s SoulCartDirection matches 2 run data modify entity @s Motion[2] set value 1.0
execute if score @s SoulCartDirection matches 3 run data modify entity @s Motion[2] set value -1.0

# (I'd line these clauses up, but commands actually fail to parse if there are
# multiple spaces between tokens.)

# This is the call that actually moves the minecart faster than normal
execute if score @s SoulCartDirection matches 0 facing ~1 ~ ~ run function soulcart:move
execute if score @s SoulCartDirection matches 1 facing ~-1 ~ ~ run function soulcart:move
execute if score @s SoulCartDirection matches 2 facing ~ ~ ~1 run function soulcart:move
execute if score @s SoulCartDirection matches 3 facing ~ ~ ~-1 run function soulcart:move

# Accelerate while high-speed conditions are met
execute if score @s SoulCartDirection matches 0.. run scoreboard players add @s SoulCartSpeed 1

# Cap at maximum speed
execute if score @s SoulCartSpeed matches 250.. run scoreboard players set @s SoulCartSpeed 250

# Decelerate while high-speed conditions are not met
execute if score @s SoulCartDirection matches -1 run scoreboard players remove @s SoulCartSpeed 5

# After teleporting check for derailement, and apply consequences. Derailment
# can occur when encountering a corner, teleporting past a corner, coming to the
# end of the track, hitting a block at the end of the track, or going up or down
# a slope.
#
# (Adding `at @s` updates the execute position to the minecart's new position
# after teleport.)
execute at @s if score @s SoulCartDirection matches 0 unless block ~ ~ ~ #minecraft:rails[shape=east_west] run function soulcart:schedule_explosion
execute at @s if score @s SoulCartDirection matches 1 unless block ~ ~ ~ #minecraft:rails[shape=east_west] run function soulcart:schedule_explosion
execute at @s if score @s SoulCartDirection matches 2 unless block ~ ~ ~ #minecraft:rails[shape=north_south] run function soulcart:schedule_explosion
execute at @s if score @s SoulCartDirection matches 3 unless block ~ ~ ~ #minecraft:rails[shape=north_south] run function soulcart:schedule_explosion
