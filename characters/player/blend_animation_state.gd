class_name BlendAnimationState
extends LimboState

@export var animation_name : StringName = &""

var animation_tree : AnimationTree
var playback : AnimationNodeStateMachinePlayback

func _enter() -> void:
	playback.travel(animation_name)
	
func _update(delta: float) -> void:
	## Updates the property direction for the state animation
	var prop := get_animation_property_path()
	var direction : Vector2 = get_parent().get_direction()
	animation_tree.set(prop, direction)

func get_animation_property_path() -> String:
	return "parameters/%s/blend_position" % animation_name
