class_name EnemyHSM
extends LimboHSM

@export var stat_controller : CharacterStatController
@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback
var states: Array[AnimationState] = []

@export var chase_state : LimboState
@export var death_state : LimboState

const ALIVE := "alive"
const DEAD := "dead"

func _ready() -> void:
	var parent := get_parent()
	var first := get_child(0)
	_setup_animation_states()
	_add_transitions()
	initialize(parent)
	set_initial_state(first)
	assert(agent != null, "Agent must be set.")
	self.set_active(true)
	stat_controller.alive_changed.connect(_on_alive_changed)
	
func _add_transitions() -> void:
	add_transition(chase_state, death_state, DEAD)
	add_transition(death_state, chase_state, ALIVE)

func _setup_animation_states() -> void:
	assert(animation_tree != null, "Animation tree must be set before calling _setup_animation_states()")
	playback = animation_tree["parameters/playback"]
	
	for child in get_children():
		if child is AnimationState:
			child.playback = playback
			child.animation_tree = animation_tree
			states.append(child)

func _on_alive_changed(p_alive : bool) -> void:
	if p_alive:
		dispatch(ALIVE)
	else:
		dispatch(DEAD)
