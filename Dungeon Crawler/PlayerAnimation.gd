# PlayerAnimation.gd

class_name PlayerAnimation
extends Component

export(NodePath) var animation_player_path = null
onready var animation_player = get_node(animation_player_path)

export(NodePath) var transform_wrapper_path = null
onready var transform_wrapper = get_node(transform_wrapper_path)

export(NodePath) var kinematic_body_2D_path = null
onready var kinematic_body_2D = get_node(kinematic_body_2D_path)

export(NodePath) var player_movement_path = null
onready var player_movement = get_node(player_movement_path)

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
			if kinematic_body_2D.test_move(transform_wrapper.transform, directions_dictionary.get(animation_direction)):
				animation_player.current_animation = str("push", animation_direction)
	elif player_movement.move_direction != Vector2.ZERO:
		if animation_player.current_animation != str("walk", animation_direction):
			animation_player.play(str("walk", animation_direction))
	
