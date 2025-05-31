## Defines where an object can be hit
class_name HurtBox2D
extends Area2D

## Used for damage calculations and health change assignments
@export var stat_controller : CharacterStatController

func _ready() -> void:
	assert(stat_controller != null, "Must assign the stat controller for damage calculation.")
	stat_controller.alive_changed.connect(_on_alive_changed)

## Deal damage to the target. Runs calculations through the source weapon and then applied to the character stat controller
## to finalize the amount and apply to the HP
##
## Returns true if hit was successful, or false if hurtbox skipped
func try_hit(source : Projectile) -> bool:
	if not stat_controller.alive:
		return false
	
	var base_damage := source.calculate_damage()
	var final_damage : int = stat_controller.calculate_damage(base_damage)
	var new_hp : int = int(stat_controller.hp - final_damage)
	stat_controller.hp = new_hp
	CombatSystem.instance.report_change(stat_controller.object, final_damage)
	return true

func _on_alive_changed(p_alive : bool) -> void:
	set_deferred(&"monitorable", p_alive)
