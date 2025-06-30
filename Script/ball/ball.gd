#extends RigidBody3D
#class_name Ball
#
#@export var reset_position: Vector3 = Vector3.ZERO
#@export var reset_velocity: Vector3 = Vector3.ZERO
#@export var reset_angular_velocity: Vector3 = Vector3.ZERO
#
#var last_player: Node = null
#var last_touch_time: float = 0.0
#
#func _ready():
	## Initialize reset position if not set
	#if reset_position == Vector3.ZERO:
		#reset_position = global_transform.origin
#
	## Connect signal to detect collisions with players
	#if not is_connected("body_entered", Callable(self, "_on_ball_body_entered")):
		#connect("body_entered", Callable(self, "_on_ball_body_entered"))
#
#func reset():
	#var new_transform = global_transform
	#new_transform.origin = reset_position
	#set_global_transform(new_transform)
	#linear_velocity = reset_velocity
	#angular_velocity = reset_angular_velocity
	#sleeping = false
#
#func apply_kick(from: Node, direction: Vector3, strength: float):
	#if strength <= 0:
		#return
	#last_player = from
	#last_touch_time = Time.get_ticks_msec() / 1000.0
	#var impulse = direction.normalized() * strength
	#apply_impulse(Vector3.ZERO, impulse)
#
#func _on_ball_body_entered(body: Node):
	#if body.has_method("on_ball_collision"):
		#body.on_ball_collision(self)
#
#func _integrate_forces(_state):
	## Gradual slowdown
	#linear_velocity *= 0.98
	#angular_velocity *= 0.98
