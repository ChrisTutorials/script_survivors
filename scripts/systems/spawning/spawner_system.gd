class_name SpawnerSystem
extends Node

@export var spawn_margin: float = 10.0
@export var spawn_extra_range: float = 100.0 # Additional random offset beyond margin
@export var random_definitions : Array[SpawningDefinition]
@export var spawn_parent : Node2D
@export var min_spawn_interval: float = 0.1
@export var max_spawn_interval: float = 0.3

## Dictionary for Spawn Definitions and Runtime Stats for easy lookup
var random_spawn_stats : Dictionary[SpawningDefinition, SpawnStats]

var elapsed_time: float = 0.0
var player : Node2D
var spawn_timer: float = 0.0
var next_spawn_time: float = 0.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	assert(player)
	
	for definition in random_definitions:
		random_spawn_stats[definition] = SpawnStats.new()

	next_spawn_time = randf_range(min_spawn_interval, max_spawn_interval)

func _process(delta: float) -> void:
	elapsed_time += delta
	spawn_timer += delta
	
	if spawn_timer >= next_spawn_time:
		random_spawn()
		spawn_timer = 0.0
		next_spawn_time = randf_range(min_spawn_interval, max_spawn_interval)

func get_randomly_spawnable() -> Array[SpawningDefinition]:
	var spawnable : Array[SpawningDefinition] = []
	
	for definition : SpawningDefinition in random_spawn_stats.keys():
		var can_spawn : bool = definition.can_spawn(elapsed_time, random_spawn_stats[definition])
		
		if can_spawn:
			spawnable.append(definition)
		
	return spawnable

func get_spawn_position_near_player() -> Vector2:
	var angle := randf_range(0, TAU)
	var spawn_position := player.global_position + Vector2(cos(angle), sin(angle)) * spawn_margin
	return spawn_position

## Selects an offscreen position by picking an edge and then selecting a position
## an offset in that edge direction away from the player to spawn the scene at
func get_spawn_position_off_camera() -> Vector2:
	var camera := get_viewport().get_camera_2d()
	
	if camera == null:
		push_error("No Camera2D found in viewport.")
		return player.global_position
	
	var cam_center: Vector2 = camera.global_position
	var cam_size: Vector2 = Vector2(get_viewport().size) / camera.zoom
	var cam_rect := Rect2(cam_center - cam_size * 0.5, cam_size)
	
	var edge := randi() % 4
	var offset := spawn_margin + randf() * spawn_extra_range
	var spawn_pos := Vector2.ZERO
	
	if edge <= 1: # Top or Bottom
		spawn_pos.x = randf_range(cam_rect.position.x, cam_rect.position.x + cam_rect.size.x)
		spawn_pos.y = cam_rect.position.y - offset if edge == 0 else cam_rect.position.y + cam_rect.size.y + offset
	else: # Left or Right
		spawn_pos.y = randf_range(cam_rect.position.y, cam_rect.position.y + cam_rect.size.y)
		spawn_pos.x = cam_rect.position.x - offset if edge == 2 else cam_rect.position.x + cam_rect.size.x + offset
	
	return spawn_pos

## Randomly spawn one of the scenes in the SpawningDefinitions
## that are ready for spawning
func random_spawn() -> void:
	var spawnable : Array[SpawningDefinition] = get_randomly_spawnable()
	
	if spawnable.is_empty():
		return
	
	var selected : SpawningDefinition = select_random_spawn(spawnable)
	var spawn_pos := get_spawn_position_off_camera()
	var enemy := selected.scene.instantiate()
	spawn_parent.add_child(enemy)
	enemy.global_position = spawn_pos
	
	## Update the stats after spawning
	var spawn_stats := random_spawn_stats[selected]
	spawn_stats.spawned_count += 1
	spawn_stats.last_spawn_time = elapsed_time

func select_random_spawn(possible_defs: Array[SpawningDefinition]) -> SpawningDefinition:
	# Return null if there are no possible definitions
	if possible_defs.is_empty():
		return null

	# Calculate the total weight of all definitions
	var total_weight: float = 0.0
	for def in possible_defs:
		total_weight += def.weight

	# Pick a random value between 0 and total_weight
	var random_value: float = randf() * total_weight
	var running_weight: float = 0.0

	# Find the definition that matches the random value
	for def in possible_defs:
		running_weight += def.weight
		if random_value < running_weight:
			return def

	# Fallback: return the last definition if something goes wrong
	return possible_defs.back()
