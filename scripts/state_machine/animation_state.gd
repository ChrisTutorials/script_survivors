class_name AnimationState
extends LimboState

@export var animation_name : StringName = &""

var animation_tree : AnimationTree
var playback : AnimationNodeStateMachinePlayback

func _enter() -> void:
	playback.travel(animation_name)

## Update the animation when the direction changes
func handle_direction_change(_p_facing : Vector2, _p_last : Vector2) -> void:
	return
