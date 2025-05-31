## NPC tries to run towards player
class_name ChaseState
extends AnimationState

@export var sensor : PlayerSensor

var npc : NPC

func _setup() -> void:
	npc = agent as NPC
	
	assert(sensor != null, "Sensor must be set for ChaseState to resolve player location.")
	assert(agent is NPC, "Agent must be an NPC for ChaseState")

## Move towards the player
func _update(_delta: float) -> void:
	var speed := npc.stats.get_speed()
	var npc_position :=  npc.global_position
	var player_position := sensor.player.global_position
	var to_player := npc_position.direction_to(player_position)
	npc.velocity = to_player * speed
	npc.move_and_slide()
	
