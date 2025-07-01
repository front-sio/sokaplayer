class_name PlayerStateDribbling
extends PlayerState

func _physics_process(_delta: float) -> void:
	player.input_2d_direction = KeyUtils.get_input_vector(player.control_scheme)
	handle_dribbling()
	handle_dribble_animation()

func handle_dribbling() -> void:
	player.velocity = Vector3(player.input_2d_direction.y, 0, player.input_2d_direction.x) * player.speed

func handle_dribble_animation() -> void:
	if player.input_2d_direction.length() > 0.1:
		var target_rotation_angle = atan2(player.velocity.x, player.velocity.z)
		player.rotation.y = lerp_angle(player.rotation.y, target_rotation_angle, 0.2)
		animation_player.play("Dribble")
	else:
		animation_player.play("Idle")
