## Selects the player from the player group on load
## Use player reference any time you need to target or track it
class_name PlayerSensor
extends Node2D

var player : Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
