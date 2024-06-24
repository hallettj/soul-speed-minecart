# This function is run by `main` which ensures thot `@s` is a minecart with
# a player

# Capture current minecart speed. Scoreboards hold integers, while motion vector
# components are doubles. So we use the `scale` option to multiply the speed by
# 100 to get an integer approximation.
execute store result score @s RacecartXSpeed run data get entity @s Motion[0] 100
execute store result score @s RacecartZSpeed run data get entity @s Motion[2] 100

# Check if minecart is going at a minimum speed (0.9) on a straight piece of
# rail that is placed over soul soul. If so increment its speed scoreboard value
# in the direction the minecart is travelling.
execute as @s[scores={RacecartXSpeed=90..}] at @s if block ~ ~ ~ #minecraft:rails[shape=east_west] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players add @s RacecartXSpeed 5
execute as @s[scores={RacecartXSpeed=..-90}] at @s if block ~ ~ ~ #minecraft:rails[shape=east_west] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players remove @s RacecartXSpeed 5
execute as @s[scores={RacecartZSpeed=90..}] at @s if block ~ ~ ~ #minecraft:rails[shape=north_south] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players add @s RacecartZSpeed 5
execute as @s[scores={RacecartZSpeed=..-90}] at @s if block ~ ~ ~ #minecraft:rails[shape=north_south] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players remove @s RacecartZSpeed 5
#
# execute as @s[scores={RacecartXSpeed=90..}] at @s if block ~ ~ ~ #minecraft:rails[shape=east_west] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s RacecartXSpeed 225
# execute as @s[scores={RacecartXSpeed=..-90}] at @s if block ~ ~ ~ #minecraft:rails[shape=east_west] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s RacecartXSpeed -225 
# execute as @s[scores={RacecartZSpeed=90..}] at @s if block ~ ~ ~ #minecraft:rails[shape=north_south] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s RacecartZSpeed 225 
# execute as @s[scores={RacecartZSpeed=..-90}] at @s if block ~ ~ ~ #minecraft:rails[shape=north_south] if block ~ ~-1 ~ minecraft:soul_soil run scoreboard players set @s RacecartZSpeed -225

# Show soul particles
execute as @s[scores={RacecartXSpeed=95..}] at @s if block ~1 ~ ~ #minecraft:rails[shape=east_west] if block ~1 ~-1 ~ minecraft:soul_soil facing ~1 ~ ~ run function racecarts:move
execute as @s[scores={RacecartXSpeed=..-95}] at @s if block ~-1 ~ ~ #minecraft:rails[shape=east_west] if block ~-1 ~-1 ~ minecraft:soul_soil facing ~-1 ~ ~ run function racecarts:move
execute as @s[scores={RacecartZSpeed=95..}] at @s if block ~ ~ ~1 #minecraft:rails[shape=north_south] if block ~ ~-1 ~1 minecraft:soul_soil facing ~ ~ ~1 run function racecarts:move
execute as @s[scores={RacecartZSpeed=..-95}] at @s if block ~ ~ ~-1 #minecraft:rails[shape=north_south] if block ~ ~-1 ~-1 minecraft:soul_soil facing ~ ~ ~-1 run function racecarts:move

# Cap speed at 1.0 which is the max value that the game allows
execute as @s[scores={RacecartXSpeed=100..}] run scoreboard players set @s RacecartXSpeed 100
execute as @s[scores={RacecartXSpeed=..-100}] run scoreboard players set @s RacecartXSpeed -100
execute as @s[scores={RacecartZSpeed=100..}] run scoreboard players set @s RacecartZSpeed 100
execute as @s[scores={RacecartZSpeed=..-100}] run scoreboard players set @s RacecartZSpeed -100

# Set increased minecart speed. Multiply by 0.01 to reverse the scoreboard scale
# factor. This is just to make sure that the minecart keeps moving at a base
# speed. The actual "faster minecart" behavior is achived with the tp command in
# the `move` function.
execute as @s[scores={RacecartXSpeed=95..}] store result entity @s Motion[0] double 0.01 run scoreboard players get @s RacecartXSpeed
execute as @s[scores={RacecartXSpeed=..-95}] store result entity @s Motion[0] double 0.01 run scoreboard players get @s RacecartXSpeed
execute as @s[scores={RacecartZSpeed=95..}] store result entity @s Motion[2] double 0.01 run scoreboard players get @s RacecartZSpeed
execute as @s[scores={RacecartZSpeed=..-95}] store result entity @s Motion[2] double 0.01 run scoreboard players get @s RacecartZSpeed
