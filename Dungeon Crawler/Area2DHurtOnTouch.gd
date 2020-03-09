# Area2DHurtOnTouch.gd

class_name Area2DHurtOnTouch
extends Component

onready var area_2D = get_parent()

export(int) var hurt_recovery_time = 1

var recovering_areas = Array()
var recovering_timers = Array()

func _physics_process(delta):
	for area in area_2D.get_overlapping_areas():
		if area.get_parent().has_child_type(Health) and !recovering_areas.has(area):
			area.get_parent().get_single_child_type(Health).hurt(1)
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
