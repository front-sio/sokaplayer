class_name Ball
extends RigidBody3D

enum State { CARRIED, FREEFORM, SHOT }
@onready var mesh = %ball
@onready var collision = %CollisionShape3D
@onready var ball_animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_detection_area: Area3D = %PlayerDetectionArea

@export var dribble_frequency : float
@export var dribble_intensity : float
var carrier: Player = null
var current_state: BallState = null
var state_factory := BallStateFactory.new()
var velocity := Vector3.ZERO

func _ready() -> void:
	mesh.scale = Vector3(0.11, 0.11, 0.11)
	collision.shape.radius = 0.11
	switch_state(State.FREEFORM)

func switch_state(state: Ball.State) -> void:
	if current_state != null:
		current_state.queue_free()

	# ✅ always assign a new state
	current_state = state_factory.get_fresh_state(state)

	# 🟡 Optional: reassign carrier if needed
	# if state == State.CARRIED:
	#     carrier = self.carrier

	current_state.setup(self, player_detection_area, carrier, ball_animation_player)
	current_state.state_transition_requested.connect(switch_state)
	current_state.name = "BallStateMachine"
	call_deferred("add_child", current_state)
