extends KinematicBody2D


var MAX_SPEED = 100

var stop = 0

var ACCELERATION = 5

var motion = Vector2.ZERO



func _physics_process(delta):
	
	var axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_movement(axis*ACCELERATION*MAX_SPEED*.8)
		
	else:
		ACCELERATION += 1
		apply_movement(axis*ACCELERATION)
	
	motion = move_and_slide(motion)



func get_input_axis():
	
	var axis = Vector2.ZERO
	
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	return axis.normalized()



func instantstop():
	
	motion = Vector2.ZERO
	




func apply_movement(acceleration):
	
	motion = acceleration
	
	motion.clamped(MAX_SPEED)
