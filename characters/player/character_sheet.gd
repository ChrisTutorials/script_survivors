## Handles runtime calculation for effective character statstics
class_name CharacterSheet
extends Node

@export var base_stats : BaseStats

## The minimum cooldown multiplier that can be applied to a base cast speed. 1.0 is 100% normal cooldown time.
const MINIMUM_CD : float = 0.01

## Gets the effective cooldown reduction for the character
func get_cooldown_multiplier() -> float:
	return max(1 - base_stats.cooldown_reduction, MINIMUM_CD)
