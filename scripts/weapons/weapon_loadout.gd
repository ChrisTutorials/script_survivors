## Manages attacks, cooldowns, and timers for a character
class_name WeaponLoadout
extends Node2D

@export var weapons : Array[Weapon] = []

var weapon_timers : Dictionary[Weapon, Timer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
