# Health.gd

class_name Health
extends Component

export(int) var health = 100

func hurt(damage: int):
	health -= damage
