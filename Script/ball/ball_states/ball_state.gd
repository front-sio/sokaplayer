class_name BallState
extends Node

signal state_transition_requested(new_state: Ball.State)

var ball: Ball = null
var carrier: Player = null
var player_detection_area: Area3D = null
var ball_animation_palyer: AnimationPlayer = null

func setup(context_ball: Ball, context_player_detection_area: Area3D, context_carrier: Player, context_ball_animation_palyer: AnimationPlayer) -> void:
	ball = context_ball
	ball_animation_palyer = context_ball_animation_palyer
	player_detection_area = context_player_detection_area
	carrier = context_carrier
