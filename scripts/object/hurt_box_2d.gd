## Defines where an object can be hit
class_name HurtBox2D
extends Area2D

## Used for damage calculations and health change assignments
@export var stat_controller : CharacterStatController

## Deal damage to the target. Runs calculations through the source weapon and then applied to the character stat controller
## to finalize the amount and apply to the HP
func hit(source : Projectile) -> void:
	var base_damage := source.calculate_damage()
	var final_damage := stat_controller.calculate_damage(base_damage)
	stat_controller.hp -= final_damage
