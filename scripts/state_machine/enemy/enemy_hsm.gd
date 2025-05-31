class_name EnemyHSM
extends LimboHSM

@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback
var states: Array[AnimationState] = []

@export var chase_state : LimboState

func _ready() -> void:
	var parent := get_parent()
	var first := get_child(0)
	_setup_animation_states()
	initialize(parent)
	set_initial_state(first)
	assert(agent != null, "Agent must be set.")
	self.set_active(true)

func _setup_animation_states() -> void:
	assert(animation_tree != null, "Animation tree must be set before calling _setup_animation_states()")
	playback = animation_tree["parameters/playback"]
	
	for child in get_children():
		if child is AnimationState:
			child.playback = playback
			child.animation_tree = animation_tree
			states.append(child)
