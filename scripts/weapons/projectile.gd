class_name Projectile
extends StaticBody2D

## Direction the projectile is moving
var direction : Vector2

## Statistics for the weapon level
var level : WeaponLevel

var _launched = false

## Starts moving the projectile in the direction parameter
func launch(p_direction : Vector2, p_weapon_level : WeaponLevel) -> void:
	direction = p_direction
	level = p_weapon_level
	_launched = true

func _physics_process(delta: float) -> void:
	if not _launched:
		return
		
	var collided = move_and_collide(direction * level.speed)
