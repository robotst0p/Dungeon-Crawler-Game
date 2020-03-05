extends Node2D

var TYPE = "BULLET"
const DAMAGE = 1
var t
var attackdir
var distance
var originpos


func create(position, dir):
	t = self.get_transform()
	t.origin = position
	originpos = position
	self.set_transform(t)
	attackdir = dir

func _process(delta):
	distance = (self.transform.origin - originpos).length()
	if (distance > 256):
		queue_free()
	var t = self.get_transform()
	t.origin = t.origin + self.attackdir * 1/20
	self.set_transform(t)

