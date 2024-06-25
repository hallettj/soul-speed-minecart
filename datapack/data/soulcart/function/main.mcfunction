execute as @e[type=minecraft:minecart] at @s if entity @p[distance=..1] if block ~ ~-1 ~ minecraft:soul_soil unless score @s SoulCartExploding matches 1.. run function soulcart:accelerate

execute as @e[scores={SoulCartExploding=1..}] at @s run function soulcart:explode
