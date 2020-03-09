# TransformWrapper.gd



class_name TransformWrapper
extends Component

export(Transform2D) var transform = Transform2D.IDENTITY setget set_transform, get_transform

func set_transform(t: Transform2D):
	transform = t
	
func get_transform():
	return transform
