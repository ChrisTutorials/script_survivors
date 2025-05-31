## Instance of a weapon. Declared as resource for easy inspector setting.
class_name Weapon
extends Node2D

## Current level of the weapon 
var level_idx : int = 0

@export var definition : WeaponDefinition

var input : PlayerInput
var timer : Timer
var _parent : WeaponLoadout


func _ready() -> void:
	_parent = get_parent()
	assert(_parent.input != null, "Weapons depend on the WeaponLoadout input reference to work.")
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	assert(timer.is_stopped(), "Don't start until start is called.")

func start(p_sheet : CharacterSheet) -> void:
	update_cooldown(p_sheet)
	timer.start()

## Creates the projectile instance(s) for the weapon in the game world
func cast(p_direction : Vector2) -> void:
	var scene : PackedScene = definition.get_scene(level_idx)
	var instance : Node2D = scene.instantiate()
	
	if instance is Projectile:
		instance.launch(p_direction, definition.get_level(level_idx))

## Calculate the cooldown per cast and set the timers wait time to that cooldown duration
func update_cooldown(p_sheet : CharacterSheet) -> void:
	var base := definition.levels[level_idx].cooldown
	var percent_modifier := p_sheet.get_cooldown_multiplier()
	var cooldown : float = base * percent_modifier
	assert(cooldown > 0.0, "Duration must be some positive number.")
	timer.wait_time = cooldown

func _on_timer_timeout() -> void:
	cast(_parent.input.direction)
