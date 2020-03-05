extends Node2D

var TYPE = null
const DAMAGE = 1
var direction

var maxamount = 1

onready var bullet_scene = load("res://Projectiles/bullet.tscn")
onready var player = get_parent()
onready var first_level = get_tree().get_root()

var bullet
var location

func direction(attackdir):
	var t = get_transform()
	t = t.rotated(atan2(attackdir.y, attackdir.x))
	self.set_transform(t)
	direction = attackdir
	location = player.transform.origin
	TYPE = "SWORD"
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing", "down"))
	bullet = bullet_scene.instance()
	bullet.create(location, direction)
	first_level.add_child(bullet)
	
func destroy(animation):
	queue_free()
	
