## Runtime stats for a projectile instance
class_name ProjectileStats
extends RefCounted

## Minumum effect that the projectile can do per hit
var power_min : int

## Maximum effect that the projectile can do per hit
var power_max : int

## Speed at which the projectile travels (if any)
var speed : float

## Number of hits the projectile instance can do before removal.
var max_hits : int = 1

func are_hits_limited() -> bool:
	return max_hits > 0
