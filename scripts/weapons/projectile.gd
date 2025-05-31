class_name Projectile
extends StaticBody2D

## Direction the projectile is moving
var direction : Vector2

## Runtime stats for this instance of the weapon projectile
var stats : ProjectileStats

var _launched := false

## Starts moving the projectile in the direction parameter
func launch(p_direction : Vector2, p_stats : ProjectileStats) -> void:
	direction = p_direction
	stats = p_stats
	_launched = true

func _physics_process(_delta: float) -> void:
	if not _launched:
		return
		
	var collision : KinematicCollision2D = move_and_collide(direction * stats.speed)
