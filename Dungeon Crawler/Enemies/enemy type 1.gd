extends "res://Engine/entity.gd"

var TYPE = "ENEMY"
var action =  ""
var pushtoggle = 0
var speed = 40
var DAMAGE = 1
var movetimer_length = 15
var player = get_parent().get_node("player")
var playerpos

var viewport

func _ready():
#	$blood.set_emitting(false)
	set_collision_mask_bit(1,1)
	viewport = get_tree().get_root()
	$anim.play("default")
	movedir = dir.rand()
	set_physics_process(false)
	$process.connect("viewport_entered",self,"entered_viewport")
	$process.connect("viewport_exited",self,"exited_viewport")
	
func _physics_process(delta):
	playerpos = player.transform.origin
	movement_loop(speed)
	damage_loop(TYPE)
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length

func entered_viewport(viewport_in):
	if viewport == viewport_in:
		set_physics_process(true)
		pass
		
func exited_viewport(viewport_in):
	if viewport == viewport_in:
		set_physics_process(false)
