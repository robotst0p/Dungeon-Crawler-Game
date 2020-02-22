extends Camera2D
var TYPE = "CAMERA"

func _process(delta):
	var pos = get_node("../player").global_position - Vector2(0,16)
	var x = floor(pos.x/256) * 256
	var y = floor(pos.y / 240) * 240
	global_position = lerp(global_position, Vector2(x,y), 0.1)