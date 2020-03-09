# TransformCoupling.gd

tool

class_name TransformCoupling
extends Component



export(NodePath) var transform_holder_leader_path = null setget set_transform_holder_leader_path, get_transform_holder_leader_path
onready var transform_holder_leader = get_node(transform_holder_leader_path)

func set_transform_holder_leader_path(path: NodePath) -> void:
	transform_holder_leader_path = path
	transform_holder_leader = get_node(transform_holder_leader_path)
	
func get_transform_holder_leader_path() -> NodePath:
	return transform_holder_leader_path
	


export(NodePath) var transform_holder_follower_path = null setget set_transform_holder_follower_path, get_transform_holder_follower_path
onready var transform_holder_follower = get_node(transform_holder_follower_path)

func set_transform_holder_follower_path(path: NodePath) -> void:
	transform_holder_follower_path = path
	transform_holder_follower = get_node(transform_holder_follower_path)
	
func get_transform_holder_follower_path() -> NodePath:
	return transform_holder_follower_path



export(bool) var couple_origin_x = false
export(bool) var couple_origin_y = false
export(bool) var couple_rotation = false # measured CCW from +x axis
export(bool) var couple_scale_x = false
export(bool) var couple_scale_y = false
export(bool) var couple_x_hat = false
export(bool) var couple_y_hat = false



func _process(_delta):
	if couple_origin_x:
		transform_holder_follower.transform.origin.x = transform_holder_leader.transform.origin.x
	if couple_origin_y:
		transform_holder_follower.transform.origin.y = transform_holder_leader.transform.origin.y
	if couple_rotation:
		transform_holder_follower.transform.x = transform_holder_follower.transform.get_scale().x * Vector2(cos(transform_holder_leader.transform.get_rotation()), sin(transform_holder_leader.transform.get_rotation()))
		transform_holder_follower.transform.y = transform_holder_follower.transform.get_scale().y * Vector2(-sin(transform_holder_leader.transform.get_rotation()), cos(transform_holder_leader.transform.get_rotation()))
	if couple_scale_x:
		transform_holder_follower.transform.x = transform_holder_follower.transform.x.normalized() * transform_holder_leader.transform.get_scale().x
	if couple_scale_y:
		transform_holder_follower.transform.y = transform_holder_follower.transform.y.normalized() * transform_holder_leader.transform.get_scale().y
	if couple_x_hat:
		transform_holder_follower.transform.x = transform_holder_leader.transform.x
	if couple_y_hat:
		transform_holder_follower.transform.y = transform_holder_leader.transform.y
