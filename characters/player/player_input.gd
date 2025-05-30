## Gets player input for the player
class_name PlayerInput
extends Node

var direction : Vector2

func _input(event: InputEvent) -> void:
	direction = Input.get_vector(
		InputActions.LEFT,
		InputActions.RIGHT,
		InputActions.UP,
		InputActions.DOWN
	)
