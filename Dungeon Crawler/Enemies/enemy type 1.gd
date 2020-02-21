extends "res://Engine/entity.gd"

var TYPE = "ENEMY"
var action =  ""
var pushtoggle = 0
var speed = 40
var DAMAGE = 1
var movetimer_length = 15

func _ready():
		$anim.play("default")
		movedir = dir.rand()
		set_physics_process(false)
		
		
func _physics_process(delta):
	movement_loop(speed)
	damage_loop(TYPE)
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length

		
		


func _on_process_viewport_exited(viewport):
	pass # Replace with function body.
