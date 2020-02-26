extends "res://Engine/entity.gd"

var TYPE = "PLAYER"

var speed = 70
var action = ""
var pushtoggle = 0
var pulltoggle = 0
var DAMAGE = 2
var state = "default"
var keys = 0
var dashtimer = 0
var recovertime = 30
var dashflag = true




func _physics_process(delta):
	if dashtimer >= 0:
		dashtimer -= 1
		speed = 200
	recovertime -= 1
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	keys = min(keys, 9)

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
	var DASH = Input.is_action_just_pressed(("dash"))
		
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	if DASH and recovertime <= 0 and hud.get("stamina") >= 20:
		dashtimer = 10
		recovertime = 30
		emit_signal("stamina_change")
		
	




	


