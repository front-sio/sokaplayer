extends Node


enum Action {LEFT, RIGHT, UP, DOWN, SHOOT, PASS}


const ACTIONS_MAP : Dictionary = {
	
	Player.ControlScheme.P1 : {
		Action.LEFT: 'player1_left',
		Action.RIGHT: 'player1_right',
		Action.UP: 'player1_up',   # Mapped to forward movement in 3D
		Action.DOWN: 'player1_down', # Mapped to backward movement in 3D
		Action.SHOOT: 'player1_shoot',
		Action.PASS: 'player1_pass',
	},

	Player.ControlScheme.P2 : {
		Action.LEFT: 'player2_left',
		Action.RIGHT: 'player2_right',
		Action.UP: 'player2_up',   # Mapped to forward movement in 3D
		Action.DOWN: 'player2_down', # Mapped to backward movement in 3D
		Action.SHOOT: 'player2_shoot',
		Action.PASS: 'player2_pass',
	},
}


func get_input_vector(scheme: Player.ControlScheme) -> Vector2:
	
	if not ACTIONS_MAP.has(scheme):
		return Vector2.ZERO 

	var map : Dictionary = ACTIONS_MAP[scheme]
	
	
	return Input.get_vector(map[Action.RIGHT], map[Action.LEFT], map[Action.UP], map[Action.DOWN])
	

func is_action_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
	if not ACTIONS_MAP.has(scheme) or not ACTIONS_MAP[scheme].has(action):
		return false
	return Input.is_action_pressed(ACTIONS_MAP[scheme][action])


func is_action_just_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
	if not ACTIONS_MAP.has(scheme) or not ACTIONS_MAP[scheme].has(action):
		return false
	return Input.is_action_just_pressed(ACTIONS_MAP[scheme][action])


func is_action_just_released(scheme: Player.ControlScheme, action: Action) -> bool:
	if not ACTIONS_MAP.has(scheme) or not ACTIONS_MAP[scheme].has(action):
		return false
	return Input.is_action_just_released(ACTIONS_MAP[scheme][action])
