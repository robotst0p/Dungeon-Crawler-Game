# AIRandomMovement.gd

class_name AIRandomMovement
extends Component

export(NodePath) var kinematic_body_2D_path
onready var kinematic_body_2D = get_node(kinematic_body_2D_path)

export(int) var speed = 5
export(int) var move_time = 1
onready var timer = Timer.new()

var move_direction = Vector2.ZERO

func _ready():
	timer.set_wait_time(move_time)
	timer.set_one_shot(true)
	add_child(timer)
	
func _physics_process(_delta):
	if timer.is_stopped():
		randomize()
		var phi = rand_range(0, 2 * PI)
		move_direction = speed * Vector2(cos(phi), sin(phi))
		timer.start()
		
	kinematic_body_2D.move_and_slide(move_direction)
