## State machine for the player character that uses input
## to trigger events and send information to the active child state
class_name PlayerHSM
extends LimboHSM

## Player character body to initialize as the agent
@export var player : Player

## Holds blend spaces for 2D directional animations
@export var animation_tree : AnimationTree

## Input for the player
@export var input : PlayerInput

## The standing still state for the player 
@export var idle_state : BlendAnimationState

## The moving state for the player
@export var run_state : BlendAnimationState

var states : Array[BlendAnimationState] = []
var playback : AnimationNodeStateMachinePlayback

const STOPPED_EVENT := &"stopped"
const MOVING_EVENT := &"moving"

func _ready() -> void:
	assert(player != null, "Player agent must be set on the HSM")
	assert(animation_tree != null, "Animation tree must be set on the HSM")
	assert(input != null, "Input must be set on the HSM")
	input.direction_changed.connect(_on_direction_changed)
	input.facing_changed.connect(_on_facing_changed)
	_setup_hsm()
	assert(not states.is_empty(), "Requires at least one LimboState")

## Setup initial state and initialize with the player as the agent
func _setup_hsm() -> void:
	playback = animation_tree["parameters/playback"]
	setup_states()
	setup_transitions()
	set_initial_state(states[0])
	initialize(player)
	self.set_active(true)

## Find all child states to define states
## Then give them access to playback and animation tree with direction references
func setup_states() -> void:
	for child in get_children():
		if child is BlendAnimationState:
			states.append(child)
	
	for state in states:
		if state == null:
			push_warning("Null state found in states")
			continue
		
		state.playback = playback
		state.animation_tree = animation_tree

## Create state transitions between different states for
## when certain events are dispatched in the state machine
func setup_transitions() -> void:
	add_transition(run_state, idle_state, STOPPED_EVENT)
	add_transition(idle_state, run_state, MOVING_EVENT)

## Dispatch transition events for when the character starts and stops movement
## Passes the signal data to the child state for further processing
func _on_direction_changed(p_direction : Vector2, p_last : Vector2) -> void:
	if p_direction == Vector2.ZERO:
		dispatch(STOPPED_EVENT)
	elif p_last == Vector2.ZERO:
		dispatch(MOVING_EVENT)
		
func _on_facing_changed(p_facing : Vector2, p_last : Vector2) -> void:
	for state in states:
		state.handle_direction_change(p_facing, p_last)
