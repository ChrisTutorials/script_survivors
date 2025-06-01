class_name FloatingCombatText
extends Control

@onready var label : Label = $Label
@onready var animation_player : AnimationPlayer = $AnimationPlayer

## Pass the text to the control's labels
func set_text(p_text : String) -> void:
	label.text = p_text
	
func play() -> void:
	animation_player.seek(0.0)
	animation_player.play(&"rise")

func _ready() -> void:
	# Duplicate the animation library to ensure it's unique per instance
	for lib_name in animation_player.get_animation_library_list():
		var lib: AnimationLibrary = animation_player.get_animation_library(lib_name)
		if lib:
			animation_player.remove_animation_library(lib_name)
			animation_player.add_animation_library(lib_name, lib.duplicate(true))
