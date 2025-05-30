## Gets player input for the player
class_name PlayerInput
extends Node

signal direction_changed(direction : Vector2)

var direction : Vector2 :
	set(value):
		if direction == value:
			return
			
		direction = value
		direction_changed.emit(direction)

## Update input direction every frame
func _process(_delta : float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action(InputActions.LEFT) || event.is_action(InputActions.RIGHT) || event.is_action(InputActions.UP) || event.is_action(InputActions.DOWN):
		direction = Input.get_vector(
			InputActions.LEFT,
			InputActions.RIGHT,
			InputActions.UP,
			InputActions.DOWN
		)
