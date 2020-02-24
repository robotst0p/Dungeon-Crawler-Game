extends CanvasLayer

var animatedhealth = 0

func _ready():
	pass 


func _process(delta):
	pass

func _on_health_change():
	print("health decrease")





func _on_player_health_change():
	print("player health has decreased")
	$Tween.interpolate_property(self, "animatedhealth", 20, 6, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN) 
	if not $Tween.is_active():
		$Tween.start()
