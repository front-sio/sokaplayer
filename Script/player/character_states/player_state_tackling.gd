class_name PlayerStateTackling
extends PlayerState


const DURATION_TACKLE := 200 # Duration of the tackle animation in milliseconds
var time_start_tackle := 0.0 # Time when tackle started, using float for milliseconds



func _enter_tree() -> void:
	animation_player.play("FallenIdle")
	time_start_tackle = Time.get_ticks_msec()


func _physics_process(delta: float) -> void:
	if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
		state_transition_requested.emit(Player.State.MOVING)

#func handle_tackling_state() -> void:
	#player.velocity = Vector3.ZERO 
	#if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
		#player.state = player.State.MOVING 
#
#
#
#func transition_to_tackling() -> void:
	#player.state = player.State.TACKLING
	#time_start_tackle = Time.get_ticks_msec()
	#player.velocity = Vector3.ZERO 
