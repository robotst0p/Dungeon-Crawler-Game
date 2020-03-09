# EnemyHurtPlayerOnTouch.gd

class_name EnemyHurtPlayerOnTouch
extends Component

onready var my_area = get_parent()

export(int) var damage_on_hit = 1
export(float) var hurt_recovery_time = 0.5

onready var timer = Timer.new()

func _ready():
	timer.set_wait_time(hurt_recovery_time)
	timer.set_one_shot(true)
	add_child(timer)

func _physics_process(_delta):
	var overlap = my_area.get_overlapping_areas()
	if overlap.size() > 0 and timer.is_stopped():
		timer.start()
		var player = get_game_object(overlap[0])
		player.get_child_of_type(Health).hurt(damage_on_hit)
		var movement = player.get_child_of_type(PlayerMovement)
		movement.stun()
		movement.knock_back(overlap[0].global_position - my_area.global_position)
