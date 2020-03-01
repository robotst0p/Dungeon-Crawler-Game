extends CanvasLayer

onready var hpbar = $UI/bars/healthbar/TextureProgress
onready var xpbar = $UI/bars/xpbar/TextureProgress
onready var staminabar = $UI/bars/staminabar/TextureProgress
onready var player = get_parent().get_node("player")


var health = 100
var processxp = 0
var stamina = 100

var keys = 0
var level = 1

var i = 0


func _ready():
	pass 


func _process(delta):
	if stamina < 100:
		stamina += .05
	hpbar.value = health
	xpbar.value = processxp
	staminabar.value = stamina
	keys = player.get("keys")
	$key_label.text = str(keys)
	$level_label.text = "Level: " + str(level)

func level_up():
	level += 1
	processxp = 0
	player.level_up()
#	for i in range(0, $level_up_label.get_total_character_count()):
#		$level_up_label.set_visible_characters(i)

func _on_player_health_change():
	$Tween.interpolate_property(self, "health", health, health - 30, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _on_xp_change():
	if (xpbar.value == 100):
		level_up()
		
	$Tween.interpolate_property(self, "processxp", processxp, processxp + 40, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _on_stamina_change():
	$Tween.interpolate_property(self, "stamina", stamina, stamina - 20, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()