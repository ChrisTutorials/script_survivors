class_name CombatSystem
extends Node

## Emitted whenever an object's health changes
signal health_change(object : Node2D, change : int)

static var instance : CombatSystem :
	set(value):
		if instance != null:
			push_warning("Singleton system. Cannot set a new instance, you should only have one.")
			return
		
		instance = value

func _init():
	instance = self
