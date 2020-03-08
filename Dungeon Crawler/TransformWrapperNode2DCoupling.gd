# TransformNode2DCoupling.gd

class_name TransformNode2DCoupling
extends Component

export(NodePath) var transform_wrapper_path = null
onready var transform_wrapper = get_node(transform_wrapper_path)

export(NodePath) var node_2D_path = null
onready var node_2D = get_node(node_2D_path)

enum LeaderType { TransformWrapper, Node2D }
export(LeaderType) var leader_type

export(bool) var couple_origin_x = false
export(bool) var couple_origin_y = false
export(bool) var couple_rotation = false # measured CCW from +x axis
export(bool) var couple_scale_x = false
export(bool) var couple_scale_y = false
export(bool) var couple_x_hat = false
export(bool) var couple_y_hat = false
	
func _process(_delta):
	if leader_type == LeaderType.TransformWrapper:
		if couple_origin_x:
			node_2D.transform.origin.x = transform_wrapper.transform.origin.x
		if couple_origin_y:
			node_2D.transform.origin.y = transform_wrapper.transform.origin.y
		if couple_rotation:
			node_2D.transform.x = node_2D.transform.get_scale().x * Vector2(cos(transform_wrapper.transform.get_rotation()), sin(transform_wrapper.transform.get_rotation()))
			node_2D.transform.y = node_2D.transform.get_scale().y * Vector2(-sin(transform_wrapper.transform.get_rotation()), cos(transform_wrapper.transform.get_rotation()))
		if couple_scale_x:
			node_2D.transform.x = node_2D.transform.x.normalized() * transform_wrapper.transform.get_scale().x
		if couple_scale_y:
			node_2D.transform.y = node_2D.transform.y.normalized() * transform_wrapper.transform.get_scale().y
		if couple_x_hat:
			node_2D.transform.x = transform_wrapper.transform.x
		if couple_y_hat:
			node_2D.transform.y = transform_wrapper.transform.y
	elif leader_type == LeaderType.Node2D:
		if couple_origin_x:
			transform_wrapper.transform.origin.x = node_2D.transform.origin.x
		if couple_origin_y:
			transform_wrapper.transform.origin.y = node_2D.transform.origin.y
		if couple_rotation:
			transform_wrapper.transform.x = transform_wrapper.transform.get_scale().x * Vector2(cos(node_2D.transform.get_rotation()), sin(node_2D.transform.get_rotation()))
			transform_wrapper.transform.y = transform_wrapper.transform.get_scale().y * Vector2(-sin(node_2D.transform.get_rotation()), cos(node_2D.transform.get_rotation()))
		if couple_scale_x:
			transform_wrapper.transform.x = transform_wrapper.transform.x.normalized() * node_2D.transform.get_scale().x
		if couple_scale_y:
			transform_wrapper.transform.y = transform_wrapper.transform.y.normalized() * node_2D.transform.get_scale().y
		if couple_x_hat:
			transform_wrapper.transform.x = node_2D.transform.x
		if couple_y_hat:
			transform_wrapper.transform.y = node_2D.transform.y
