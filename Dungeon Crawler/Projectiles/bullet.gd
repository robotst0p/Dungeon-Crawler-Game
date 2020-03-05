extends Node2D

var TYPE = "BULLET"
const DAMAGE = 1
var t
var attackdir


func create(position, dir):
	t = self.get_transform()
	t.origin = position
	self.set_transform(t)
	attackdir = dir

func _process(delta):
	var t = self.get_transform()
	t.origin = t.origin + self.attackdir * 1/20
	self.set_transform(t)

