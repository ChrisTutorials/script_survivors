class_name FloatingCombatTextSystem
extends Node

## Scene path to instantiate for each floating combat text
@export_file("*.tscn") var text_scene_path : String

var text_scene : PackedScene

func _ready():
	CombatSystem.instance.health_change.connect(_on_health_changed)
	assert(text_scene_path != null, "Must assign a FloatingCombatText scene")
	assert(FileAccess.file_exists(text_scene_path), "Invalid file at path %s" % text_scene_path)
	text_scene = load(text_scene_path)
	assert(text_scene != null, "PackedScene should be loaded but wasn't")

## Report a change to the system to display text
func report_change(p_object : Node2D, p_change : int) -> void:
	var text_instance : Control = text_scene.instantiate()
	add_child(text_instance)
	text_instance.global_position = p_object.global_position
	var new_text := str(p_change)
	text_instance.set_text(new_text)

func _on_health_changed(p_obj : Node2D, p_change : int) -> void:
	report_change(p_obj, p_change)
