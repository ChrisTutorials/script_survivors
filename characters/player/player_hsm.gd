class_name PlayerHSM
extends LimboHSM

## Player character body to initialize as the agent
@export var player : Player

## Holds blend spaces for 2D directional animations
@export var animation_tree : AnimationTree

## Input for the player
@export var input : PlayerInput

@export var states : Array[BlendAnimationState] = []

var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	assert(player != null, "Player agent must be set on the HSM")
	assert(animation_tree != null, "Animation tree must be set on the HSM")
	assert(input != null, "Input must be set on the HSM")
	assert(not states.is_empty(), "Requires at least one LimboState")
	input.direction_changed.connect(_on_direction_changed)
	_setup_hsm()

## Setup initial state and initialize with the player as the agent
func _setup_hsm() -> void:
	playback = animation_tree["parameters/playback"]
	setup_states()
	set_initial_state(states[0])
	initialize(player)
	self.set_active(true)

func setup_states() -> void:
	for state in states:
		if state == null:
			push_warning("Null state found in states")
			continue
		
		state.playback = playback
		state.animation_tree = animation_tree

func get_direction() -> Vector2:
	return input.direction

func _on_direction_changed(p_direction : Vector2):
	var state := self.get_active_state()
	
	if state is BlendAnimationState:
		state.handle_direction_change(p_direction)
