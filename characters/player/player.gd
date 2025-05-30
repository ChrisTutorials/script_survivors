## Controls basic movement for the player character
class_name Player
extends CharacterBody2D

## Default speed for how fast the player should walk
@export var input : PlayerInput
@export var walk_speed := 100.0

func _ready() -> void:
	assert(input != null, "Player input must be set.")

func _physics_process(_delta: float) -> void:
	if input.direction:
		velocity = input.direction * walk_speed
	else:
		velocity = Vector2(
			move_toward(velocity.x, 0, walk_speed),
			move_toward(velocity.y, 0, walk_speed)
			)

	move_and_slide()
