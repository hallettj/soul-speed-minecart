# Teleport 3 blocks in the direction of travel to simulate moving much faster
# than a normal minecart.
tp ^ ^ ^3

# RacecartTimer is used to control how often soul particles appear.
# Decrement RacecartTimer every tick while the value is greater than zero.
execute if score @s RacecartTimer matches 1.. run scoreboard players remove @s RacecartTimer 1

# Produce a particle every fourth invocation to reduce lag.
execute unless score @s RacecartTimer matches 1.. run particle minecraft:soul ^ ^ ^6 0.2 0.5 0.2 0 1

# Restart RacecartTimer when it reaches zero, or if it has not been set before.
execute unless score @s RacecartTimer matches 1.. run scoreboard players set @s RacecartTimer 3
