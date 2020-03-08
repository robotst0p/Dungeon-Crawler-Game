# Spin.gd

class_name Spin
extends Component

export(NodePath) var transform_holder_path
onready var transform_holder = get_node(transform_holder_path)

var time = 0
var spin_speed = 7

func _physics_process(delta):
	time += delta
	
#	key
#	transform_holder.transform.x = Vector2(cos(spin_speed * time), 0)
#	transform_holder.transform.y = Vector2(0, sin(spin_speed * time))

	transform_holder.transform.x = Vector2(sin(PI * time / 0.2) + 1.5, 0)
	transform_holder.transform.y = Vector2(0, sin(PI * time / 0.2) + 1.5)

#	transform_holder.transform.x = Vector2(0.5 * (1 + cos(spin_speed * time)), 0)
#	transform_holder.transform.y = Vector2(0, 1)
