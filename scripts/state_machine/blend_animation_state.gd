## LimboState that has access
## to animation_tree and the playback
## for changing animations and controlling
## facing direction for the animation_name
class_name BlendAnimationState
extends LimboState

@export var animation_name : StringName = &""

var animation_tree : AnimationTree
var playback : AnimationNodeStateMachinePlayback

func _enter() -> void:
	playback.travel(animation_name)

func get_animation_property_path() -> String:
	return "parameters/%s/blend_position" % animation_name

## Update the animation when the direction changes
func handle_direction_change(p_direction : Vector2, _p_last : Vector2) -> void:
	if p_direction == Vector2.ZERO:
		return
		
	var prop := get_animation_property_path()
	animation_tree.set(prop, p_direction)
