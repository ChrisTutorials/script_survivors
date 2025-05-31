## Manages attacks, cooldowns, and timers for a character
class_name WeaponLoadout
extends Node2D

@export var sheet : CharacterSheet
@export var input : PlayerInput

var weapons : Array[Weapon] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(sheet != null, "A character sheet reference must be set to resolve cooldown timers")
	
	for child in get_children():
		if child is not Weapon:
			push_warning("Unexpected child %s of WeaponLoadout is not a Weapon" % child)
		
		if child is Weapon:
			weapons.append(child)	
			child.start(sheet)
