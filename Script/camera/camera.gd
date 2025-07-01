extends Camera3D

@export var target: Ball  # Assign your ball node here
@export var height: float = 10.0
@export var distance: float = 20.0
@export var follow_speed: float = 5.0

var last_target_pos: Vector3
var velocity: Vector3 = Vector3.ZERO

func _ready():
	if target:
		last_target_pos = target.global_transform.origin

func _process(delta: float) -> void:
	if not target:
		return

	var current_pos = target.global_transform.origin
	velocity = (current_pos - last_target_pos) / delta
	last_target_pos = current_pos

	# Ignore vertical velocity, focus on horizontal movement
	var horizontal_velocity = Vector3(velocity.x, 0, velocity.z)
	var speed = horizontal_velocity.length()

	# Use movement direction if moving enough, otherwise fallback to ball's facing direction
	var direction = (speed > 0.1) if horizontal_velocity.normalized() else -target.global_transform.basis.z.normalized()

	# Position camera behind the ball relative to movement direction
	var desired_position = current_pos - direction * distance + Vector3.UP * height

	# Smoothly interpolate camera position
	global_transform.origin = global_transform.origin.lerp(desired_position, delta * follow_speed)

	# Look at the ball, keep camera upright
	look_at(current_pos, Vector3.UP)
