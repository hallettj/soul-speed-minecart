execute as @e[type=minecraft:minecart] at @s if entity @p[distance=..1] if block ~ ~-1 ~ minecraft:soul_soil run function racecarts:startcart

execute as @e[scores={RacecartExploding=1..}] at @s run function racecarts:explode
