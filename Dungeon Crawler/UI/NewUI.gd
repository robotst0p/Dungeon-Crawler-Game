extends CanvasLayer

onready var hpbar = $UI/bars/healthbar/TextureProgress
onready var xpbar = $UI/bars/xpbar/TextureProgress
onready var player = get_parent().get_node("player")

var health = 100
var xp = 0
var keys = 0

func _ready():
	pass 


func _process(delta):
	hpbar.value = health
	xpbar.value = xp
	keys = player.get("keys")
	$keylabel.text = str(keys)
	print(hpbar.value)
	print(xpbar.value)


func _on_player_health_change():
	$Tween.interpolate_property(self, "health", health, health - 30, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_xp_change():
	$Tween.interpolate_property(self, "xp", xp, xp + 50, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()