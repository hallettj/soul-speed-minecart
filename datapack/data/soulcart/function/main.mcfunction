execute as @e[type=minecraft:minecart] at @s unless score @s SoulCartExploding matches 1.. run function soulcart:accelerate
execute as @e[scores={SoulCartExploding=1..}] at @s run function soulcart:explode
