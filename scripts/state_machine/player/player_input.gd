## Action handling logic for InputMap defined actions relevant
## to the player character
class_name PlayerInput
extends Node

signal direction_changed(new : Vector2, last : Vector2)
signal facing_changed(new : Vector2, last : Vector2)

## The direction the player is inputting for movement
## X is left, right
## Y is up, down
var direction : Vector2 :
	set(value):
		if direction == value:
			return
		
		var old : Vector2 = direction
		direction = value
		
		direction_changed.emit(direction, old)
		
## The direction the player is trying to face
## Should never be Vector2.ZERO
var facing := Vector2.DOWN :
	set(value):
		if facing == value:
			return
			
		if value == Vector2.ZERO:
			push_warning("Character can never face Vector2.ZERO. Skipping facing setter.")
			return
		
		var old := facing
		facing = value
		facing_changed.emit(facing, old)

## Update input direction every frame
func _process(_delta : float) -> void:
	pass

## Handle the direction input change when keys are pressed
## to reduce processing calls
func _input(event: InputEvent) -> void:
	if _is_movement_action(event):
		var input : Vector2 = Input.get_vector(
			InputActions.LEFT,
			InputActions.RIGHT,
			InputActions.UP,
			InputActions.DOWN
		)
		
		direction = input
		
		if input != Vector2.ZERO:
			facing = input

## Determine if the action is a movement input action
func _is_movement_action(event : InputEvent) -> bool:
	return event.is_action(InputActions.LEFT) || event.is_action(InputActions.RIGHT) || event.is_action(InputActions.UP) || event.is_action(InputActions.DOWN)
