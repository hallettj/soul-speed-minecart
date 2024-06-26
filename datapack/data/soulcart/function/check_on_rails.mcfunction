# Check if cart is on straight, level track of any type matching its direction
# of travel. If yes set `SoulCartOnRails` to 1, otherwise set it to 0.

scoreboard players set @s SoulCartOnRails 0

execute if score @s SoulCartDirection matches 0..1 if block ~ ~ ~ minecraft:rail[shape=east_west] run scoreboard players set @s SoulCartOnRails 1
execute if score @s SoulCartDirection matches 2..3 if block ~ ~ ~ minecraft:rail[shape=north_south] run scoreboard players set @s SoulCartOnRails 1

execute if score @s SoulCartDirection matches 0..1 if block ~ ~ ~ minecraft:powered_rail[shape=east_west] run scoreboard players set @s SoulCartOnRails 1
execute if score @s SoulCartDirection matches 2..3 if block ~ ~ ~ minecraft:powered_rail[shape=north_south] run scoreboard players set @s SoulCartOnRails 1

execute if score @s SoulCartDirection matches 0..1 if block ~ ~ ~ minecraft:detector_rail[shape=east_west] run scoreboard players set @s SoulCartOnRails 1
execute if score @s SoulCartDirection matches 2..3 if block ~ ~ ~ minecraft:detector_rail[shape=north_south] run scoreboard players set @s SoulCartOnRails 1

execute if score @s SoulCartDirection matches 0..1 if block ~ ~ ~ minecraft:activator_rail[shape=east_west] run scoreboard players set @s SoulCartOnRails 1
execute if score @s SoulCartDirection matches 2..3 if block ~ ~ ~ minecraft:activator_rail[shape=north_south] run scoreboard players set @s SoulCartOnRails 1
