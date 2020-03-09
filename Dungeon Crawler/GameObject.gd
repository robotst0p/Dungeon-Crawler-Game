# GameObject.gd

extends Node
class_name GameObject

func has_child_type(child_class) -> bool:
	for i in range(get_child_count()):
		if get_child(i) is child_class:
			return true
	return false

func get_single_child_type(child_class):
	for child in get_children():
		if child is child_class:
			return child
	return null
