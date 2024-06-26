# Summon creeper set to explode instantly.
execute if score @s SoulCartExploding matches 2 run summon creeper ~ ~ ~ {ExplosionRadius:1,ignited:1b,Fuse:0}

# Destroy the minecart in case it was not destroyed by the explosion. This can
# happen if mobGriefing is set to false, or if the creeper is summoned inside
# a solid block.
#
# Use `damage` instead of `kill` so that the cart drops as an item.
#
# This runs the next tick after the explosion so that the dropped cart item is
# not destroyed.
execute if score @s SoulCartExploding matches 1 run damage @s 5 minecraft:explosion

scoreboard players remove @s SoulCartExploding 1
