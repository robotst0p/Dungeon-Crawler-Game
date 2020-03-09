# Area2DHurtOnTouch.gd

class_name Area2DHurtOnTouch
extends Component

onready var my_area = get_parent()

export(int) var damage_on_hit = 1
export(int) var hurt_recovery_time = 1

var recovering_areas = Array()
var recovering_timers = Array()

func _physics_process(_delta):
	for area in my_area.get_overlapping_areas():
		var area_game_object = get_game_object(area)
		if area_game_object.has_child_of_type(Health) and !recovering_areas.has(area):
			area_game_object.get_child_of_type(Health).hurt(damage_on_hit)
			
			if area_game_object.has_child_of_type(PlayerMovement):
				var movement = area_game_object.get_child_of_type(PlayerMovement)
				movement.stun()
				movement.knock_back(area.global_position - my_area.global_position)
			
			var timer = Timer.new()
			timer.set_wait_time(hurt_recovery_time)
			timer.set_one_shot(true)
			timer.set_autostart(true)
			recovering_areas.push_back(area)
			recovering_timers.push_back(timer)
			add_child(timer)
			
	for timer in recovering_timers:
		if timer.is_stopped():
			var i = recovering_timers.find(timer)
			recovering_timers.remove(i)
			recovering_areas.remove(i)
