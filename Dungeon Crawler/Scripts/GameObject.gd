# GameObject.gd

extends Node
class_name GameObject

func has_child_of_type(child_class) -> bool:
	for i in range(get_child_count()):
		if get_child(i) is child_class:
			return true
	return false

func get_child_of_type(child_class):
	for child in get_children():
		if child is child_class:
			return child
	return null
	
func get_children_of_type(child_class):
	var child_class_array = Array()
	for child in get_children():
		if child is child_class:
			child_class_array.push_back(child)
	return child_class_array
