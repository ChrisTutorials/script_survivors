## Manages attacks, cooldowns, and timers for a character
class_name WeaponLoadout
extends Node2D

@export var sheet : CharacterSheet
@export var weapons : Array[Weapon] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(sheet != null, "A character sheet reference must be set to resolve cooldown timers")
	
	for weapon in weapons:
		if weapon == null:
			push_warning("Null weapon in WeaponLoadout.")
			continue
		
		weapon.start(sheet)
