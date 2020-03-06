extends Node2D

var TYPE = "ENEMY PROJECTILE"
const DAMAGE = 1
var t
var attackdir
var originpos
var distance


func create(position, dir):
	t = self.get_transform()
	t.origin = position
	originpos = position
	self.set_transform(t)
	attackdir = dir

func _process(delta):
	distance = (self.transform.origin - originpos).length()
	if (distance > 300):
		queue_free()
	var t = self.get_transform()
	t.origin = self.transform.origin + self.attackdir.normalized() * 1/2
	self.set_transform(t)