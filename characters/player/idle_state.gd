extends LimboState

var playback : AnimationNodeStateMachinePlayback

func _enter() -> void:
	playback.travel("idle")
