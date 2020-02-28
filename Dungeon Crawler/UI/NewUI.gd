extends CanvasLayer

onready var hpbar = $UI/bars/healthbar/TextureProgress
onready var xpbar = $UI/bars/xpbar/TextureProgress
onready var staminabar = $UI/bars/staminabar/TextureProgress
onready var player = get_parent().get_node("player")

var health = 100
var xp = 0
var keys = 0
var stamina = 100

func _ready():
	pass 


func _process(delta):
	if stamina < 100:
		stamina += .05
	hpbar.value = health
	xpbar.value = xp
	staminabar.value = stamina
	keys = player.get("keys")
	$keylabel.text = str(keys)

func _on_player_health_change():
	$Tween.interpolate_property(self, "health", health, health - 30, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_xp_change():
	$Tween.interpolate_property(self, "xp", xp, xp + 50, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _on_stamina_change():
	$Tween.interpolate_property(self, "stamina", stamina, stamina - 20, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()