## Defines a scene that can be spawned, the conditions, and other spawn
## related properties to associate with the scene
class_name SpawningDefinition
extends Resource

## Scene to spawn. Can be singular character or a group
@export var scene: PackedScene

## The starting time when the scene can be spawned
@export var start_time: float

## The time moment when the scene can no longer be spawned
@export var end_time: float = 99999.0

## The maximum number of times this scene can be spawned (if any)
@export var max_count: int

## The odds of being selected randomly for spawning compared to other random spawns
@export var weight: float = 1.0 # Higher = more likely to be picked

## The minimum amount of time that must elapse between spawns
@export var min_interval: float = 0.0 # Minimum seconds between spawns

func can_spawn(current_time: float, spawn_stats : SpawnStats) -> bool:
	if current_time < start_time or current_time > end_time:
		return false
	if max_count > 0 and spawn_stats.spawned_count >= max_count:
		return false
	if current_time - spawn_stats.last_spawn_time < min_interval:
		return false
	return true
