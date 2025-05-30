## Handles runtime calculation for effective character statstics
class_name CharacterSheet
extends Node

@export var base_stats : BaseStats

## Gets the effective cooldown reduction for the character
func get_cooldown_reduction() -> float:
	return base_stats.cooldown_reduction
