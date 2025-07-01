class_name PlayerStateTackling
extends PlayerState


const DURATION_PRIOR_RECOVERY := 500 # Duration of the tackle animation in milliseconds
const GROUND_FRICTION := 450.0
var is_tackle_complete := false
var time_finish_tackle := 0.0 # Time when tackle started, using float for milliseconds



func _enter_tree() -> void:
	animation_player.play("Tackle")
	time_finish_tackle = Time.get_ticks_msec()


func _physics_process(delta: float) -> void:
	if is_tackle_complete:
		player.velocity = player.velocity.move_toward(Vector3.ZERO, delta * GROUND_FRICTION)
		if player.velocity == Vector3.ZERO:
			is_tackle_complete = true
			time_finish_tackle = Time.get_ticks_msec()
	elif Time.get_ticks_msec() - time_finish_tackle > DURATION_PRIOR_RECOVERY:
		state_transition_requested.emit(Player.State.RECOVERING)
