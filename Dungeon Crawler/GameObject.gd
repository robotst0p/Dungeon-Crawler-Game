# GameObject.gd

extends Node
class_name GameObject

func has_child_type(child_class):
	for i in range(get_child_count()):
		if get_child(i) is child_class:
			return true
	return false
