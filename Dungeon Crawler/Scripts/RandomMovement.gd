class_name RandomMovement
extends Component



# this component requires:
#	- a GameObject with a KinematicBody2D



export var speed := 5
export var move_time := 1



var walk_direction := Vector2.ZERO



onready var kinematic_body_2D = game_object.get_child_of_type(KinematicBody2D)
onready var timer = Timer.new()



func _ready():
	assert(kinematic_body_2D is KinematicBody2D)
	
	timer.set_wait_time(move_time)
	timer.set_one_shot(true)
	add_child(timer)



func _physics_process(_delta):
	if timer.is_stopped():
		randomize()
		var phi = rand_range(0, 2 * PI)
		walk_direction = speed * Vector2(cos(phi), sin(phi))
		timer.start()
		
	kinematic_body_2D.move_and_slide(walk_direction)
