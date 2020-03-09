# PlayerAnimation.gd

class_name PlayerAnimation
extends Component

onready var animation_player = game_object.get_child_of_type(AnimationPlayer)
onready var kinematic_body_2D = game_object.get_child_of_type(KinematicBody2D)
onready var player_movement = game_object.get_child_of_type(PlayerMovement)

var directions_dictionary = { Vector2(-1, 0) : "left", "left" : Vector2(-1, 0),
							  Vector2(1, 0) : "right", "right" : Vector2(1, 0),
							  Vector2(0, -1) : "up", "up" : Vector2(0, -1),
							  Vector2(0, 1) : "down", "down" : Vector2(0, 1) }
							
var animation_direction = "down"

func _ready():
	animation_player.play("idledown")
	
func _process(_delta):
	if directions_dictionary.has(player_movement.move_direction):
		animation_direction = directions_dictionary.get(player_movement.move_direction)
	
	if player_movement.move_direction == Vector2.ZERO or !player_movement.stunned_timer.is_stopped():
		if animation_player.current_animation != str("idle", animation_direction):
			animation_player.play(str("idle", animation_direction))
	elif kinematic_body_2D.is_on_wall():
		if animation_player.current_animation != str("push", animation_direction):
			if kinematic_body_2D.test_move(kinematic_body_2D.transform, directions_dictionary.get(animation_direction)):
				animation_player.current_animation = str("push", animation_direction)
	elif player_movement.move_direction != Vector2.ZERO:
		if animation_player.current_animation != str("walk", animation_direction):
			animation_player.play(str("walk", animation_direction))
	
