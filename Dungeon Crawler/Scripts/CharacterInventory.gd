class_name ChraracterInventory
extends BaseInventory



export(NodePath) var primary_weapon_path = null setget set_primary_weapon_path, get_primary_weapon_path
export(NodePath) var secondary_weapon_path = null setget set_secondary_weapon_path, get_secondary_weapon_path




onready var primary_weapon = get_node(primary_weapon_path) if primary_weapon_path != null else null
onready var secondary_weapon = get_node(secondary_weapon_path) if secondary_weapon_path != null else null



func _ready():
	var items = get_children()
	for item in items:
		if item == primary_weapon or item == secondary_weapon:
			item.get_child_of_type(Sprite).visible = true
		else:
			item.get_child_of_type(Sprite).visible = false



#func _process(_delta):
#	var items = get_children()
#	for item in items:
#		if item == primary_weapon or item == secondary_weapon:
#			pass # shoot gun



func add_item(game_object):
	game_object.get_child_of_type(Sprite).visible = false
	add_child(game_object)
	
	
	
func drop_item(game_object):
	game_object.get_child_of_type(Sprite).visible = true
	get_tree().find_node("World").add_child(game_object)
	remove_child(game_object)



func equip_item(game_object):
	pass



func set_primary_weapon_path(path: NodePath) -> void:
	primary_weapon_path = path
	
	
	
func get_primary_weapon_path():
	return primary_weapon_path
	
	
	
func set_secondary_weapon_path(path: NodePath) -> void:
	secondary_weapon_path = path
	
	
	
func get_secondary_weapon_path():
	return secondary_weapon_path
