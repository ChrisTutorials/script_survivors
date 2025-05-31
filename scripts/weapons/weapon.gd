## Instance of a weapon. Declared as resource for easy inspector setting.
class_name Weapon
extends Node2D

## Current level of the weapon 
var level_idx : int = 0

@export var definition : WeaponDefinition

var timer : Timer

var _loadout : WeaponLoadout
var _weapons_parent : Node2D

const PROJECTILES_GROUP = "projectiles"

func _ready() -> void:
	_weapons_parent = get_tree().get_first_node_in_group(PROJECTILES_GROUP)
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	assert(timer.is_stopped(), "Don't start until start is called.")

func start(p_loadout : WeaponLoadout) -> void:
	_loadout = p_loadout
	update_cooldown(_loadout.stats)
	timer.start()
	
	assert(_loadout.input != null, "Weapons depend on the WeaponLoadout input reference to work.")

## Creates the projectile instance(s) for the weapon in the game world
func cast(p_direction : Vector2) -> void:
	var scene : PackedScene = definition.get_scene(level_idx)
	var instance : Node2D = scene.instantiate()
	
	if instance is Projectile:
		_weapons_parent.add_child(instance)
		instance.global_position = _loadout.global_position
		var rotate_angle := _loadout.input.facing.angle() + PI / 2 # 90 Degrees towards the right
		instance.rotate(rotate_angle)
		var level := definition.get_level(level_idx)
		var instance_stats := ProjectileCalculator.calculate_stats(level, _loadout.stats)
		instance.launch(p_direction, instance_stats)
	else:
		push_warning("Tried to instane node %s but it is no Projectiles type. Removing..." % instance)
		instance.free()

## Calculate the cooldown per cast and set the timers wait time to that cooldown duration
func update_cooldown(p_sheet : CharacterStatController) -> void:
	var base := definition.levels[level_idx].cooldown
	var percent_modifier := p_sheet.get_cooldown_multiplier()
	var cooldown : float = base * percent_modifier
	assert(cooldown > 0.0, "Duration must be some positive number.")
	timer.wait_time = cooldown

func _on_timer_timeout() -> void:
	cast(_loadout.input.facing)
