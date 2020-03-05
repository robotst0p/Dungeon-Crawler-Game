extends TileMap

var enemies = Array()

func _ready():
	randomize()
	var landtiles = get_used_cells()
	var size = get_cell_size()
	for i in range(0,randi()%7+3):
		var spawn_location = randi()%landtiles.size()-1+1
		var tile = landtiles[spawn_location]
		spawn_enemy(tile, size,1)
	for i in range(0,randi()%2+1):
		var spawn_location = randi()%landtiles.size()-1+1
		var tile = landtiles[spawn_location]
		spawn_enemy(tile, size,2)

func spawn_enemy(tile,size,type):
	var enemy = load("res://Enemies/enemy type " + str(type) + ".tscn").instance()
	var offset = size / 2
	enemies.append(enemy)
	enemy.global_position = tile * size + offset
	get_parent().call_deferred("add_child",enemy)

#func _process(delta):
#	var size = get_cell_size()
#	var landtiles = get_used_cells()
#	for enemy in enemies:
#		if (!is_instance_valid(enemy)):
#			var spawn_location = randi()%landtiles.size()-1+1
#			var tile = landtiles[spawn_location]
#			spawn_enemy(tile,size)
#			enemies.erase(enemy)
			
	