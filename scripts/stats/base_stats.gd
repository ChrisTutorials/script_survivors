## Base statistics for a game character
class_name BaseStats
extends Resource

@export var speed : float = 100.0
@export var hp : int = 10
@export var cooldown_reduction : int = 0

## Percent bonus added to 1.0 base for multiplier total on weapon power
@export var power_percent_bonus : float = 0.01

## How much bonus speed to add to the base weapon speed. Ex. 0.50 is +50% speed.
@export_range(0.01, 10.0, 0.01, "or_greater") var weapon_speed_bonus : float = 0.0
