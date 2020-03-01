extends Node2D

var TYPE = null
const DAMAGE = 1

var maxamount = 1



var animation_name

func _ready():
	TYPE = "SWORD"
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing",get_parent().spritedir))
	
func destroy(animation):
	queue_free()