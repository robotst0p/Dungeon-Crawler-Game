extends "res://Engine/entity.gd"

var TYPE = "PLAYER"

var speed = 70
var action = ""
var pushtoggle = 0
var pulltoggle = 0
var DAMAGE = 2
var keys = 0
var dashtimer = 0
var recovertime = 30
var dashflag = true
var xplevel = 1
var level = 1
var level_animation
var mouse_pos
var attackdir

onready var levelanimation = preload("res://Player/level_up.tscn")
onready var viewport = get_viewport()

var SwordScene = preload("res://items/sword.tscn")


func _physics_process(delta):
	if dashtimer >= 0:
		dashtimer -= 1
		speed = 200
	recovertime -= 1
	match state:
		State.Default, State.Stunned:
			state_default()
		State.Attack:
			state_swing()
	keys = min(keys, 9)
	
func level_up():
	level += 1
	levelanimation.instance()
	var level_animation = levelanimation.instance()
	level_animation.create(self)
	first_level.add_child(level_animation)

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
		
#func _input(event):
#	if event is InputEventMouseButton and $hit_reset_timer.is_stopped() and state != State.Stunned:
#		state = State.Attack
#		mouse_pos = event.position
#		$hit_reset_timer.start()
#		print(mouse_pos)

func state_swing():
	controls_loop()
	anim_switch("idle")
	movement_loop(speed*1.2)
	spritedir_loop()
	damage_loop(TYPE)
	if ($hit_reset_timer.is_stopped()):
		state = State.Default

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var DASH = Input.is_action_just_pressed(("dash"))
	var ATTACK = Input.is_action_just_pressed(("a"))
		
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	if DASH and recovertime <= 0 and hud.get("stamina") >= 20:
		dashtimer = 10
		recovertime = 30
		emit_signal("stamina_change")
		
	if (ATTACK and $hit_reset_timer.is_stopped()) and state != State.Stunned:
		print(self.get_global_transform_with_canvas().origin)
		state = State.Attack
		mouse_pos = viewport.get_mouse_position()
		attackdir = mouse_pos - self.get_global_transform_with_canvas().origin
		$hit_reset_timer.start()
		use_item(SwordScene, attackdir)




	


