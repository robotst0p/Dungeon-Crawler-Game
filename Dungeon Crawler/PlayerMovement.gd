# PlayerMovement.gd

class_name PlayerMovement
extends Component

export(NodePath) var input_data_path = null
onready var input_data = get_node(input_data_path)

export(NodePath) var kinematic_body_2D_path = null
onready var kinematic_body_2D = get_node(kinematic_body_2D_path)

var move_direction = Vector2.ZERO
var knock_direction = Vector2.ZERO

export(int) var speed = 70
export(int) var stunned_speed = 125
export(int) var dash_speed = 200

export(float) var stunned_time = 0.3
export(float) var dash_time = 0.3

var stunned_timer = Timer.new()
var dash_timer = Timer.new()

export(float) var dash_recover_time = 0.5

var dash_recover_timer = Timer.new()

func _ready():
	stunned_timer.set_wait_time(stunned_time)
	stunned_timer.set_one_shot(true)
	add_child(stunned_timer)
	
	dash_timer.set_wait_time(dash_time)
	dash_timer.set_one_shot(true)
	add_child(dash_timer)
	
	dash_recover_timer.set_wait_time(dash_recover_time)
	dash_recover_timer.set_one_shot(true)
	add_child(dash_recover_timer)

func _process(_delta):
	move_direction = Vector2(-int(Input.is_action_pressed(input_data.LeftAction)) + int(Input.is_action_pressed(input_data.RightAction)),
							 -int(Input.is_action_pressed(input_data.UpAction)) + int(Input.is_action_pressed(input_data.DownAction)))

	if Input.is_action_pressed(input_data.DashAction) and dash_recover_timer.is_stopped(): # and stamina >= 20
		dash_timer.start()
		dash_recover_timer.start()
		
func _physics_process(_delta):
	var motion = Vector2.ZERO
	
	if !dash_timer.is_stopped():
		motion = move_direction.normalized() * dash_speed
	elif !stunned_timer.is_stopped():
		motion = knock_direction.normalized() * stunned_speed
	else:
		motion = move_direction.normalized() * speed
			
	kinematic_body_2D.move_and_slide(motion, Vector2(0,0))
