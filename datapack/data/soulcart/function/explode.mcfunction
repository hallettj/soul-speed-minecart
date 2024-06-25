# Summon creeper set to explode instantly. Place it slightly behind the player
# riding the minecart so that they don't see the creeper flash on the screen for
# a tick.
#execute at @p run summon creeper ^ ^ ^-0.25 {ExplosionRadius:2,ignited:1b,Fuse:0}
execute if score @s SoulCartExploding matches 2 run summon creeper ~ ~ ~ {ExplosionRadius:1,ignited:1b,Fuse:0}

# Destroy the minecart. Use `damage` instead of `kill` so that the the player
# can pick up the cart again. This runs after explosion so that dropped cart
# item is not destroyed
execute if score @s SoulCartExploding matches 1 run damage @s 5 minecraft:explosion

scoreboard players remove @s SoulCartExploding 1
