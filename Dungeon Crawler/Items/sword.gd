extends Node2D

var TYPE = null
const DAMAGE = 1

var maxamount = 1



var animation_name

func direction(attackdir):
	var t = get_transform()
	t = t.rotated(atan2(attackdir.y, attackdir.x))
	self.set_transform(t)

func _ready():
	TYPE = "SWORD"
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing", "down"))
	
func destroy(animation):
	queue_free()
	
