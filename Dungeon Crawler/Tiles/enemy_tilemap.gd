extends TileMap

func _ready():
	randomize()
	var size = get_cell_size()
	var offset = size / 2
	var tree = get_tree()
	for tile in get_used_cells():
		var name = get_tileset().tile_get_name(get_cell(tile.x,tile.y))
		spawn_enemy(tile,size,offset)
	queue_free()

func spawn_enemy(tile,size,offset):
	var node = load("res://Enemies/enemy type 1.tscn").instance()
	node.add_to_group(str("enemies",self))
	node.global_position = tile * size + offset
	get_parent().call_deferred("add_child",node)


