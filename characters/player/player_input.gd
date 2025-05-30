## Gets player input for the player
class_name PlayerInput
extends Node

var direction : Vector2

## Update input direction every frame
func process():
	direction = Input.get_vector(
		InputActions.LEFT,
		InputActions.RIGHT,
		InputActions.UP,
		InputActions.DOWN
	)

func _input(event: InputEvent) -> void:
	pass
