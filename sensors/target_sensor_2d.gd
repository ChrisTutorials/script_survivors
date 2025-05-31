## Detects targets on the mask layer
class_name TargetSensor2D
extends Area2D

signal target_changed(new : Node2D, old : Node2D)

## The current, closest target the sensor is detecting
var target : Node2D :
	set(value):
		if target == value:
			return
		
		var old := target
		target = value
		target_changed.emit(target, old)
		
var known : Array[Node2D]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(p_body : Node2D) -> void:
	known.append(p_body)
	
	target = _get_closest(known)
	
func _on_body_exited(p_body : Node2D) -> void:
	known.erase(p_body)
	
	target = _get_closest(known)

## Returns closest Node2D from the Array[Node2D] of options (null if none)
func _get_closest(p_options : Array[Node2D]) -> Node2D:
	var closest : Node2D = null
	var closest_distance : float = INF
	
	for option in p_options:
		var distance = global_position.distance_to(option.global_position)
		
		if distance < closest_distance:
			closest = option
			closest_distance = distance
	
	return closest
