# EnemyAnimation.gd

class_name EnemyAnimation
extends Component

func _ready():
	get_parent().play("enemy_default_animation")
