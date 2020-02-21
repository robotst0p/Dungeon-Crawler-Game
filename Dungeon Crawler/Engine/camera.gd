extends Camera2D
var TYPE = "CAMERA"

func _process(delta):
	var pos = get_node("../player").global_position - Vector2(0,16)
	var x = floor(pos.x/256) * 256
	var y = floor(pos.y / 240) * 240
	global_position = lerp(global_position, Vector2(x,y), 0.1)





func _on_process_viewport_entered(cameraport):
	print("ENABLE PHYSICS")
	set_physics_process(true)



func _on_process_viewport_exited(cameraport):
	print("DISABLE PHYSICS")
	set_physics_process(false)
