class_name Player
extends CharacterBody3D

const DURATION_TACKLE := 200 # Duration of the tackle animation in milliseconds

# Define the control schemes for the player
enum ControlScheme {CPU, P1, P2}
# Define the possible states of the player
enum State {MOVING, TACKLING}

# Export variables for editor control
@export var control_scheme : ControlScheme
@export var speed: float = 5.0 

# Node references
@onready var animation_player : AnimationPlayer = $player/AnimationPlayer 

# State variables
var input_2d_direction: Vector2 = Vector2.ZERO
var state := State.MOVING # Initial state is MOVING
var time_start_tackle := 0.0 # Time when tackle started, using float for milliseconds

func _physics_process(_delta: float) -> void:
	# Debug: Print current state and input length
	# print("Current State: ", State.keys()[state])
	# print("Input Direction Length: ", input_2d_direction.length())

	# Handle input based on control scheme
	if control_scheme == ControlScheme.CPU:
		input_2d_direction = Vector2.ZERO 
		velocity = Vector3.ZERO 
		pass 
	else:
		input_2d_direction = KeyUtils.get_input_vector(control_scheme)
		
		# State machine logic
		match state:
			State.MOVING:
				handle_moving_state()
				# Check for tackle input while moving
				if input_2d_direction.length() > 0.1 and KeyUtils.is_action_just_pressed(control_scheme, KeyUtils.Action.SHOOT):
					# Debug: Confirm SHOOT input is detected
					# print("SHOOT action detected! Transitioning to TACKLING.")
					transition_to_tackling()
			State.TACKLING:
				handle_tackling_state()

	# Always apply movement and update animations/rotation after state processing
	move_and_slide()
	set_movement_animation()

func handle_moving_state() -> void:
	velocity = Vector3(input_2d_direction.y, 0, input_2d_direction.x) * speed

func transition_to_tackling() -> void:
	state = State.TACKLING
	time_start_tackle = Time.get_ticks_msec()
	velocity = Vector3.ZERO 

func handle_tackling_state() -> void:
	velocity = Vector3.ZERO 
	
	# Debug: Check remaining tackle time
	# print("Tackling. Time left: ", DURATION_TACKLE - (Time.get_ticks_msec() - time_start_tackle))
	if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
		state = State.MOVING 

func set_movement_animation() -> void:
	match state:
		State.MOVING:
			if input_2d_direction.length() > 0.1:
				var target_rotation_angle = atan2(velocity.x, velocity.z)
				rotation.y = lerp_angle(rotation.y, target_rotation_angle, 0.2)
				animation_player.play("Run")
			else:
				animation_player.play("Idle")
		State.TACKLING:
			# Debug: Confirm animation trigger
			# if animation_player.current_animation != "Chip":
			#    print("Playing Chip animation!")
			animation_player.play("FallenIdle") # Directly play, as the `if` check is removed here to allow continuous playback if needed.
			# If you want it to play only once and then stop at the last frame, you can uncomment the `if` check above:
			# if animation_player.current_animation != "Chip":
			#    animation_player.play("Chip")
