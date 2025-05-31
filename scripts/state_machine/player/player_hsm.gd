## State machine for the player character that uses input
## to trigger events and send information to the active child state
class_name PlayerHSM
extends AnimationHSMBase

@export var player: Player
@export var input: PlayerInput
@export var idle_state: BlendAnimationState
@export var run_state: BlendAnimationState
@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback
var states: Array[AnimationState] = []

const STOPPED_EVENT := &"stopped"
const MOVING_EVENT := &"moving"

func _ready() -> void:
	assert(player != null, "Player agent must be set on the HSM")
	assert(input != null, "Input must be set on the HSM")
	input.direction_changed.connect(_on_direction_changed)
	input.facing_changed.connect(_on_facing_changed)
	_setup_hsm()
	assert(not states.is_empty(), "Requires at least one LimboState")

func _setup_hsm() -> void:
	_setup_animation_states()
	setup_transitions()
	set_initial_state(states[0])
	initialize(player)
	self.set_active(true)

func setup_transitions() -> void:
	add_transition(run_state, idle_state, STOPPED_EVENT)
	add_transition(idle_state, run_state, MOVING_EVENT)

func _on_direction_changed(p_direction: Vector2, p_last: Vector2) -> void:
	if p_direction == Vector2.ZERO:
		dispatch(STOPPED_EVENT)
	elif p_last == Vector2.ZERO:
		dispatch(MOVING_EVENT)

func _on_facing_changed(p_facing: Vector2, p_last: Vector2) -> void:
	for state in states:
		state.handle_direction_change(p_facing, p_last)

func _setup_animation_states() -> void:
	assert(animation_tree != null, "Animation tree must be set before calling _setup_animation_states()")
	playback = animation_tree["parameters/playback"]
	
	for child in get_children():
		if child is AnimationState:
			child.playback = playback
			child.animation_tree = animation_tree
			states.append(child)
