extends Node2D

var entity
var energyvalue = 0
onready var light = get_node("sparks").get_node("light")

func create(entity):
	self.entity = entity
	var t = get_transform()
	t.origin = entity.global_transform.origin
	animate("energyvalue", energyvalue)

func animate(name,animatevalue):
	$Tween.interpolate_property(self, str(name), animatevalue, animatevalue + 4, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _physics_process(delta):
	light.set_energy(energyvalue)
	print(light.get_energy())
	if (is_instance_valid(entity)):
		global_transform.origin = entity.global_transform.origin
	if (light.get_energy() >= 4):
		queue_free()



