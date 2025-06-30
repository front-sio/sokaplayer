class_name Player
extends CharacterBody3D


# Define the control schemes for the player
enum ControlScheme {CPU, P1, P2}
# Define the possible states of the player
enum State {MOVING, TACKLING, RECOVERING}

# Export variables for editor control
@export var control_scheme : ControlScheme
@export var speed: float = 5.0 

# Node references
@onready var animation_player : AnimationPlayer = $player/AnimationPlayer 

# State variables
var input_2d_direction: Vector2 = Vector2.ZERO
var current_state: PlayerState = null 
var state_factory := PlayerStateFactory.new()


func _ready() -> void:
	switch_state(State.MOVING)

func _physics_process(_delta: float) -> void:
	set_movement_animation()
	move_and_slide()


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
				animation_player.play("Run")
			else:
				animation_player.play("Idle")
		
			
