extends "res://Engine/entity.gd"

var TYPE = "PLAYER"

var speed = 70
var action = ""
var pushtoggle = 0
var pulltoggle = 0
var DAMAGE = 2
var state = "default"



func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()

func state_default():
	controls_loop()
	movement_loop(speed)
	spritedir_loop()
	damage_loop(TYPE)
	if is_on_wall():
		if spritedir == "left" and test_move(transform, Vector2(-1,0)):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, Vector2(1,0)):
			anim_switch("push")
		if spritedir == "up" and test_move(transform, Vector2(0,-1)):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, Vector2(0,1)):
			anim_switch("push")
	elif movedir != Vector2(0,0):
		anim_switch("walk")
		speed = 70
	else:
		anim_switch("idle")
		speed = 70
	 	
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

func state_swing():
	anim_switch("idle")
	movement_loop(speed)
	damage_loop(TYPE)
	movedir = dir.center

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
		
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	
		
	




	


