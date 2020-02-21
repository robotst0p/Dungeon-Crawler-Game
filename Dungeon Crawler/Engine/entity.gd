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
var hitstun = 0
var MAXHEALTH = 2
var texture_default = null
var texture_hurt = null
var health = MAXHEALTH
var processcounter = 0

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))
	
	
func damage_loop(TYPE):
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE == "ENEMY" and health <= 0:
			var death_animation = preload("res://Enemies/enemy_death.tscn").instance()
			get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			queue_free()
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE and body.get("TYPE") != "SWORD" and body.get("TYPE") != "PLAYER":
			hitstun = 10
			health -= body.get("DAMAGE")
			knockdir = global_transform.origin - body.global_transform.origin
		if hitstun == 0 and body.get("TYPE") == "SWORD" and TYPE != "PLAYER":
			hitstun = 10
			health -= body.get("DAMAGE")
			knockdir = global_transform.origin - body.global_transform.origin 

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
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed
	else:
		motion = knockdir.normalized() * 125
	move_and_slide(motion, Vector2(0,0))
	
func action_loop():
	pass
	
	
	
func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,1):
			spritedir = "down"
		Vector2(0,-1):
			spritedir = "up"

func anim_switch(animation):
	var newanim = str(animation,spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
		
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(),self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(item, self)).size() > newitem.maxamount:
		newitem.queue_free()