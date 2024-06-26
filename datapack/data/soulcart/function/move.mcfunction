# Teleport a few blocks in the direction of travel to simulate moving much
# faster than a normal minecart. Scale teleport distance by speed to approximate
# smooth acceleration.
#
# These values sample from a linear formula:
#
#     d = (SoulCartSpeed - 100) / 50
#
# So the maximum teleport distance per game tick is 3 blocks. That is on top of
# the minecart's base speed.

execute if score @s SoulCartSpeed matches 100..115 run tp ^ ^ ^0.3
execute if score @s SoulCartSpeed matches 116..130 run tp ^ ^ ^0.6
execute if score @s SoulCartSpeed matches 131..145 run tp ^ ^ ^0.9
execute if score @s SoulCartSpeed matches 146..160 run tp ^ ^ ^1.2
execute if score @s SoulCartSpeed matches 161..175 run tp ^ ^ ^1.5
execute if score @s SoulCartSpeed matches 176..190 run tp ^ ^ ^1.8
execute if score @s SoulCartSpeed matches 191..205 run tp ^ ^ ^2.1
execute if score @s SoulCartSpeed matches 206..220 run tp ^ ^ ^2.4
execute if score @s SoulCartSpeed matches 221..235 run tp ^ ^ ^2.7
execute if score @s SoulCartSpeed matches 236.. run tp ^ ^ ^3

# SoulCartParticleThrottle is used to control how often soul particles appear.
# Decrement SoulCartParticleThrottle every tick while the value is greater than
# zero.
execute if score @s SoulCartParticleThrottle matches 1.. run scoreboard players remove @s SoulCartParticleThrottle 1

# Produce a particle every fourth invocation to reduce lag.
execute if score @s SoulCartSpeed matches 100.. unless score @s SoulCartParticleThrottle matches 1.. run particle minecraft:soul ^ ^ ^6 0.2 0.5 0.2 0 1

# Restart SoulCartParticleThrottle when it reaches zero, or if it has not been
# set before.
execute unless score @s SoulCartParticleThrottle matches 1.. run scoreboard players set @s SoulCartParticleThrottle 3
