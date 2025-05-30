class_name PlayerHSM
extends LimboHSM

## Player character body to initialize as the agent
@export var player : Player

## Holds blend spaces for 2D directional animations
@export var animation_tree : AnimationTree

## Input for the player
@export var input : PlayerInput

@export var states : Array[LimboState] = []

var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	assert(player != null, "Player agent must be set on the HSM")
	assert(animation_tree != null, "Animation tree must be set on the HSM")
	assert(input != null, "Input must be set on the HSM")
	assert(not states.is_empty(), "Requires at least one LimboState")
	_setup_hsm()

## Setup initial state and initialize with the player as the agent
func _setup_hsm() -> void:
	playback = animation_tree["parameters/playback"]
	setup_states()
	set_initial_state(states[0])
	initialize(player)

func setup_states() -> void:
	for state in states:
		if state == null:
			push_warning("Null state found in states")
		
		state.playback = playback
