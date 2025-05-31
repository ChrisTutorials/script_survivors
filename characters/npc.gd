class_name NPC
extends CharacterBody2D

@export var stats : CharacterStatController

func _ready() -> void:
	assert(stats != null, "Each npc needs a CharacterStatController.")
