class_name BallStateCarried
extends BallState

var dribbble_time := 0.0

func _enter_tree() -> void:
	assert(carrier != null)
	ball.freeze = true



func _process(delta: float) -> void:
	var vx := 0.0
	dribbble_time += delta
	if carrier:
		vx = cos(dribbble_time * ball.dribble_frequency) * ball.dribble_intensity
		if carrier.velocity != Vector3.ZERO:
			ball_animation_palyer.play("roll")
		else:
			ball_animation_palyer.play('ball_idle')
		var offset = carrier.global_transform.basis.z.normalized() * 0.8
		ball.global_transform.origin =  carrier.global_transform.origin + offset 


func _exit_tree() -> void:
	ball.freeze = false
