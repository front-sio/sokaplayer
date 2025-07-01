class_name Player
extends CharacterBody3D

enum ControlScheme { CPU, P1, P2 }
enum State { MOVING, TACKLING, RECOVERING, DRIBBLING }

@export var control_scheme: ControlScheme
@export var speed: float = 5.0
@export var ball: Ball  # Assign this in the editor

@onready var animation_player: AnimationPlayer = $player/AnimationPlayer

var input_2d_direction: Vector2 = Vector2.ZERO
var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()

func _ready() -> void:
	switch_state(State.MOVING)

func _physics_process(_delta: float) -> void:
	# Handle movement
	move_and_slide()

	# Automatically switch to DRIBBLING if this player is carrying the ball
	if ball != null and ball.carrier == self and current_state.name != "PlayerStateMachine: DRIBBLING":
		switch_state(State.DRIBBLING)

	# Switch back to MOVING if the ball is not carried
	elif ball != null and ball.carrier != self and current_state.name == "PlayerStateMachine: DRIBBLING":
		switch_state(State.MOVING)

func switch_state(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_state.bind())
	current_state.name = "PlayerStateMachine: " + str(state)
	call_deferred("add_child", current_state)

func set_movement_animation() -> void:
	if input_2d_direction.length() > 0.1:
		var target_rotation_angle = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, target_rotation_angle, 0.2)

		# ✅ Play DRIBBLE animation if in DRIBBLING state
		if current_state.name == "PlayerStateMachine: DRIBBLING":
			animation_player.play("Dribble")
		else:
			animation_player.play("Run")
	else:
		animation_player.play("Idle")
