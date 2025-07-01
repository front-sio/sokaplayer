class_name BallStateFreeform
extends BallState


func _enter_tree() -> void:
	# Connect the body_entered signal.
	player_detection_area.body_entered.connect(on_player_enter.bind())
	print("BallStateFreeform: Entered tree. Player detection area connected.")


func on_player_enter(body: Node3D) -> void:
	print("BallStateFreeform: Body entered detection area: ", body.name, " (Type: ", body.get_class(), ")")
	if body is Player:
		print("BallStateFreeform: Detected a Player! Assigning carrier and requesting CARRIED state.")
		ball.carrier = body
		state_transition_requested.emit(Ball.State.CARRIED)
	else:
		print("BallStateFreeform: Entered body is NOT a Player. Ignoring.")
