extends Camera2D

onready var playerview = get_parent().get_parent()
onready var minimap = get_parent()
#var playervision = playerview.get_viewport()
#
func _ready():
	var playervision = playerview.get_viewport()
	playervision.set_use_own_world(true)
	print("test")
#	playerview.set_use_own_world(true)
#	minimap.set_use_own_world(true)
#	minimap.set_custom_viewport(playervision)
#
#
#
func _process(delta):
	var playervision = playerview.get_viewport()
	set_custom_viewport(playerview)

