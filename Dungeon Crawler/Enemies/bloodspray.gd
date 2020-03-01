extends Particles2D

var entity

func create(entity, direction: Vector2):
	self.set_one_shot(true)
	self.entity = entity
	var t = get_transform()
	t = t.rotated(atan2(direction.y, direction.x))
	t.origin = entity.global_transform.origin
	self.set_transform(t)
	self.set_emitting(true)
	
func _physics_process(delta):
	if (is_instance_valid(entity)):
		global_transform.origin = entity.global_transform.origin
		
	if (capture_rect() == Rect2(0,0,0,0)):
		queue_free()