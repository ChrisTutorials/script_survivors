## Controls basic movement for the player character
class_name Player
extends CharacterBody2D

## Default speed for how fast the player should walk
@export var input : PlayerInput
@export var stats : CharacterStatController

func _ready() -> void:
	assert(input != null, "Player input must be set.")

func _physics_process(_delta: float) -> void:
	var current_speed := stats.get_speed()
	
	if input.direction:
		velocity = input.direction * current_speed
	else:
		velocity = Vector2(
			move_toward(velocity.x, 0, current_speed),
			move_toward(velocity.y, 0, current_speed)
			)

	move_and_slide()
