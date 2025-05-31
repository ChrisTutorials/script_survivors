## Handles runtime calculation for effective character statstics
class_name CharacterStatController
extends Node

signal alive_changed(alive : bool)

@export var base_stats : BaseStats

## The health points the object has left
var hp : float :
	set(value):
		if hp == value:
			return
		
		hp = value
		alive = hp > 0

## Whether the object is alive
var alive : bool = true :
	set(value):
		if alive == value:
			return
		
		alive = value
		alive_changed.emit(alive)
		
## The object that this stats controller represents
var object : Node2D

## The minimum cooldown multiplier that can be applied to a base cast speed. 1.0 is 100% normal cooldown time.
const MINIMUM_CD : float = 0.01

## Absolute minimum weapon speed multiplier
const MINIMUM_WEAPONS_SPEED : float = 0.01

func _ready() -> void:
	object = get_parent()
	assert(object is Node2D, "Owning object should be located as the parent of this node.")
	
	assert(base_stats != null, "Base Stats must be assigned to the CharacterStatController.")
	hp = base_stats.hp

func get_speed() -> float:
	return max(0, base_stats.speed)

## Gets the effective cooldown reduction for the character
func get_cooldown_multiplier() -> float:
	return max(1 - base_stats.cooldown_reduction, MINIMUM_CD)

## Gets the effective weapon speed for the character
func get_weapon_speed_multiplier() -> float:
	return max(1.0 + base_stats.weapon_speed_bonus, MINIMUM_WEAPONS_SPEED)

## Gets the power multiplier for a character
func get_power_multiplier() -> float:
	return 1 + base_stats.power_percent_bonus

## Calculates the final damage after stats, buffs, debuffs, etc are applied
func calculate_damage(p_base : float) -> int:
	return roundi(p_base)
	
