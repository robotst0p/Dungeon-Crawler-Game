extends KinematicBody2D
var x1 = 0
var x2 = 0
var y1 = 0
var y2 = 0
var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "down"
var blockmove = Vector2(0,0)
var movetimer = 2
var MAXHEALTH = 2
var texture_default = null
var texture_hurt = null
var health = MAXHEALTH
var processcounter = 0
onready var hud = get_parent().get_node("Overlay")
signal health_change
signal xp_change
signal stamina_change

var stun_velocity = 125

enum State { Default, Attack, Stunned }
var state = State.Default

var hit_stun_timer
var hit_stun_time = .2

onready var BloodSpray = load("res://Enemies/bloodspray.tscn")

onready var first_level = get_tree().get_root()

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))
	connect("xp_change",hud,"_on_xp_change")	
	connect("stamina_change",hud, "_on_stamina_change")
	hit_stun_timer = Timer.new()
	hit_stun_timer.set_wait_time(hit_stun_time)
	hit_stun_timer.set_one_shot(true)
	add_child(hit_stun_timer)
	
func damage_loop(TYPE):
	if (state == State.Default):
		if TYPE == "ENEMY" and health <= 0:
			var death_animation = preload("res://Enemies/enemy_death.tscn").instance()
			get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			
			emit_signal("xp_change")
			queue_free()
			
		for area in $hitbox.get_overlapping_areas():
			var body = area.get_parent()
			if (TYPE == "PLAYER" and body.get("TYPE") == "ENEMY"):
				hurt(body.get("DAMAGE"), true)
				stun(global_transform.origin - body.global_transform.origin)
			elif (TYPE == "ENEMY" and body.get("TYPE") == "SWORD"):
				hurt(body.get("DAMAGE"), false)
				stun(global_transform.origin - body.global_transform.origin)
				
				var blood_spray = BloodSpray.instance()
				blood_spray.create(self, knockdir)
				first_level.add_child(blood_spray)
					
func hurt(damage: float, emit_signal: bool):
	if state != State.Stunned:
		health -= damage
		if (emit_signal):
			emit_signal("health_change")
				
func stun(knockback_direction: Vector2):
	hit_stun_timer.start()
	state = State.Stunned
	$Sprite.texture = texture_hurt
	knockdir = knockback_direction
	stun_velocity = 125
			
func _physics_process(delta):
	if (hit_stun_timer.is_stopped() and state == State.Stunned):
		state = State.Default
		$Sprite.texture = texture_default

func block_test(TYPE):
	if TYPE == "BLOCK":
		if movetimer > 0:
			movetimer -= 1
		if movetimer == 1:
			x1 = transform.origin.x
			y1 = transform.origin.y
		elif movetimer == 0:
			x2 = transform.origin.x
			y2 = transform.origin.y
		if movetimer == 0 and x2 > x1 and y2 > y1:
			blockmove = Vector2(1,-1)
		elif movetimer == 0 and x2 < x1 and y1 < y2:
			blockmove = Vector2(-1,1)
		elif movetimer == 0 and x2 > x1 and y1 == y2:
			blockmove = Vector2(1,0)
		elif movetimer == 0 and x2 < x1 and y1 == y2:
			blockmove = Vector2(-1,0)
		elif movetimer == 0 and x2 == x1 and y2 > y1:
			blockmove = Vector2(0,-1)
		elif movetimer == 0 and x2 == x1 and y2 < y1:
			blockmove = Vector2(0,1)
		if movetimer == 0:
			movetimer = 2

func movement_loop(speed):
	var motion = Vector2.ZERO
	match(state):
		State.Default, State.Attack:
			motion = movedir.normalized() * speed 
		State.Stunned:
			motion = knockdir.normalized() * stun_velocity
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(1,0):
			spritedir = "left"
		Vector2(-1,0):
			spritedir = "right"
		Vector2(0,1):
			spritedir = "down"
		Vector2(0,-1):
			spritedir = "up"

func anim_switch(animation):
	var newanim = str(animation,spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
		
func use_item(item, attackdir):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(),self))
	add_child(newitem)
	newitem.direction(attackdir)
	