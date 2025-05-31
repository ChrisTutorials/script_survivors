## Handles runtime calculation for effective character statstics
class_name CharacterSheet
extends Node

@export var base_stats : BaseStats

## The minimum cooldown multiplier that can be applied to a base cast speed. 1.0 is 100% normal cooldown time.
const MINIMUM_CD : float = 0.01

## Absolute minimum weapon speed multiplier
const MINIMUM_WEAPONS_SPEED : float = 0.01

## Gets the effective cooldown reduction for the character
func get_cooldown_multiplier() -> float:
	return max(1 - base_stats.cooldown_reduction, MINIMUM_CD)

## Gets the effective weapon speed for the character
func get_weapon_speed_multiplier() -> float:
	return max(1.0 + base_stats.weapon_speed_bonus, MINIMUM_WEAPONS_SPEED)

## Gets the power multiplier for a character
func get_power_multiplier() -> float:
	return 1 + base_stats.power_percent_bonus
