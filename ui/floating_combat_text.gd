class_name FloatingCombatText
extends Control

@onready var label : Label = $Label

## Pass the text to the control's labels
func set_text(p_text : String) -> void:
	label.text = p_text
