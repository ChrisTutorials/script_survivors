## Definition for a weapon in the game which can spawn a projectile after a time elapses
class_name WeaponDefinition
extends Resource

## Default icon for the weapon
@export var icon : Texture2D

@export var levels : Array[WeaponLevel]

func get_level(p_idx : int) -> WeaponLevel:
	return levels[p_idx]

## Finds the weapon instance scene at the highest level at or before the level_idx
## It goes downwards in level until it finds a scene it can return
func get_scene(level_idx : int) -> PackedScene:
	var current_idx := level_idx
	var found_path : String
	var loaded_scene : PackedScene
	
	while(current_idx >= 0):
		found_path = levels[current_idx].scene_path
		
		if not found_path.is_empty():
			break
			
	if not found_path.is_empty():
		loaded_scene = ResourceLoader.load(found_path)
	else:
		push_warning("No scene path found for weapon definition %s starting from index %s" % [self, level_idx])
	
	return loaded_scene
