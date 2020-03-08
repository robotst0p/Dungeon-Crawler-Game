# TransformWrapper.gd

tool

class_name TransformWrapper
extends Component

export(Transform2D) var transform = Transform2D.IDENTITY setget set_transform, get_transform

func set_transform(t: Transform2D):
	transform = t
	
func get_transform():
	return transform

#func _physics_process(delta):
#	for i in range(parent.get_child_count()):
#		if parent.get_child(i) is Sprite:
#			parent.get_child(i).transform = transform
