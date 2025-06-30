class_name PlayerStateMoving
extends PlayerState



func _physics_process(_delta: float) -> void:
	if player.control_scheme == player.ControlScheme.CPU:
		player.input_2d_direction = Vector2.ZERO 
		player.velocity = Vector3.ZERO 
		pass 
	else:
		player.input_2d_direction = KeyUtils.get_input_vector(player.control_scheme)
		handle_moving()
		player.set_movement_animation()


func handle_moving() -> void:
	player.velocity = Vector3(player.input_2d_direction.y, 0, player.input_2d_direction.x) * player.speed
	if player.velocity != Vector3.ZERO and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		state_transition_requested.emit(Player.State.TACKLING)
