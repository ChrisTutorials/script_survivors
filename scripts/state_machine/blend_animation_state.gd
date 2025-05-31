## LimboState that has access
## to animation_tree and the playback
## for changing animations and controlling
## facing direction for the animation_name
class_name BlendAnimationState
extends AnimationState



func get_animation_property_path() -> String:
	return "parameters/%s/blend_position" % animation_name

## Update the animation when the direction changes
func handle_direction_change(p_facing : Vector2, _p_last : Vector2) -> void:
	if p_facing == Vector2.ZERO:
		return
		
	var prop := get_animation_property_path()
	animation_tree.set(prop, p_facing)
