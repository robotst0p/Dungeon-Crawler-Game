extends "res://Engine/entity.gd"

var pushtoggle = 0
var TYPE = "BLOCK"
var speed = 5
var action = ""
func _physics_process(delta):
	damage_loop(TYPE)
	movement_loop(speed)
	


		
	
	
