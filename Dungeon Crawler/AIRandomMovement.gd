# AIRandomMovement.gd

class_name AIRandomMovement
extends Component

export(NodePath) var transformWrapperPath
onready var transformWrapper = get_node(transformWrapperPath)
	
func _physics_process(_delta):
	transformWrapper.transform.origin += Vector2(0.1, 0.1)
