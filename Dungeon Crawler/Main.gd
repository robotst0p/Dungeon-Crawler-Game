# Main.gd

class_name Main
extends Node

const GameObject = preload("res://GameObject.gd")
const Health = preload("res://Health.gd")
const AIRandomMovement = preload("res://AIRandomMovement.gd")

const PlayerScene = preload("res://newplayerscenetest.tscn")

func _ready():
	var radius = 10
	var phi = 0
	var amount_of_circles = 3
	var amount_in_circle = 4

	while amount_of_circles > 0:
		phi = 0
		while phi < 2 * PI * (1 - 1/amount_in_circle):
			spawn_player(radius * Vector2(cos(phi), sin(phi)) + Vector2(100, 100))
			phi +=  2 * PI / amount_in_circle
		radius += 30
		amount_in_circle += 8
		amount_of_circles -= 1

#	spawn_player(50 * Vector2(1, 0) + Vector2(100, 100))
#	spawn_player(50 * Vector2(0, -1) + Vector2(100, 100))

func spawn_player(var position: Vector2):
	var player = PlayerScene.instance()
	player.get_node("KinematicBody2D").transform.origin = position
	add_child(player)
