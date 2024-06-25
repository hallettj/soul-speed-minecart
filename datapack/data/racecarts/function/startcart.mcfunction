# This function is run by `main` which ensures thot `@s` is a minecart with
# a player above a soul soil block

# Capture current minecart speed. Scoreboards hold integers, while motion vector
# components are doubles. So we use the `scale` option to multiply the speed by
# 100 to get an integer approximation.
execute store result score @s RacecartXSpeed run data get entity @s Motion[0] 100
execute store result score @s RacecartZSpeed run data get entity @s Motion[2] 100

# Check if minecart is going at a minimum speed (0.9) on a straight piece of
# rail. If so keep it in constant motion.
execute if score @s RacecartXSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=east_west] run data modify entity @s Motion[0] set value 1.0
execute if score @s RacecartXSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=east_west] run data modify entity @s Motion[0] set value -1.0
execute if score @s RacecartZSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=north_south] run data modify entity @s Motion[2] set value 1.0
execute if score @s RacecartZSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=north_south] run data modify entity @s Motion[2] set value -1.0

# (I'd line these clauses up, but commands actually fail to parse if there are
# multiple spaces between tokens.)

# This is the call that actually moves the minecart faster than normal. Teleport
# the minecart forward 3 blocks, and show soul particles every four ticks.
execute if score @s RacecartXSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=east_west] facing ~1 ~ ~ run function racecarts:move
execute if score @s RacecartXSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=east_west] facing ~-1 ~ ~ run function racecarts:move
execute if score @s RacecartZSpeed matches 90.. if block ~ ~ ~ #minecraft:rails[shape=north_south] facing ~ ~ ~1 run function racecarts:move
execute if score @s RacecartZSpeed matches ..-90 if block ~ ~ ~ #minecraft:rails[shape=north_south] facing ~ ~ ~-1 run function racecarts:move

# After teleporting check for derailement, and apply consequences. Derailment
# can occur when encountering a corner, teleporting past a corner, coming to the
# end of the track, or hitting a block at the end of the track. (Adding `at @s`
# updates the execute position to the minecart's new position after teleport.)
execute at @s if score @s RacecartXSpeed matches 90.. unless block ~ ~ ~ #minecraft:rails[shape=east_west] at @p run function racecarts:explode
execute at @s if score @s RacecartXSpeed matches ..-90 unless block ~ ~ ~ #minecraft:rails[shape=east_west] at @p run function racecarts:explode
execute at @s if score @s RacecartZSpeed matches 90.. unless block ~ ~ ~ #minecraft:rails[shape=north_south] at @p run function racecarts:explode
execute at @s if score @s RacecartZSpeed matches ..-90 unless block ~ ~ ~ #minecraft:rails[shape=north_south] at @p run function racecarts:explode
