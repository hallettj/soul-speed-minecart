execute store result score @s RacecartXSpeed run data get entity @s Motion[0] 100
execute store result score @s RacecartZSpeed run data get entity @s Motion[2] 100

execute as @s[scores={RacecartXSpeed=90..}] at @s if block ~1 ~ ~ #minecraft:rails[shape=east_west] if block ~1 ~-1 ~ minecraft:soul_soil facing ~1 ~ ~ run function racecarts:move
execute as @s[scores={RacecartXSpeed=..-90}] at @s if block ~-1 ~ ~ #minecraft:rails[shape=east_west] if block ~-1 ~-1 ~ minecraft:soul_soil facing ~-1 ~ ~ run function racecarts:move
execute as @s[scores={RacecartZSpeed=90..}] at @s if block ~ ~ ~1 #minecraft:rails[shape=north_south] if block ~ ~-1 ~1 minecraft:soul_soil facing ~ ~ ~1 run function racecarts:move
execute as @s[scores={RacecartZSpeed=..-90}] at @s if block ~ ~ ~-1 #minecraft:rails[shape=north_south] if block ~ ~-1 ~-1 minecraft:soul_soil facing ~ ~ ~-1 run function racecarts:move
