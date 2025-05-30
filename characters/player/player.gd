class_name Player
extends CharacterBody2D

## Default speed for how fast the player should walk
@export var walk_speed = 300.0

func _physics_process(delta: float) -> void:
	## Player Movement
	var direction : Vector2 = Input.get_vector(InputActions.LEFT, InputActions.RIGHT, InputActions.UP, InputActions.DOWN)
	
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)

	move_and_slide()
