# Main.gd

class_name Main
extends Node

const PlayerScene = preload("res://newplayerscenetest.tscn")

#func _ready():
#	spawn_player_circle(Vector2.ZERO)
#
#func spawn_player_circle(origin: Vector2) -> void:
#	var radius = 10
#	var phi = 0
#	var amount_of_circles = 3
#	var amount_in_circle = 4
#
#	while amount_of_circles > 0:
#		phi = 0
#		while phi < 2 * PI * (1 - 1/amount_in_circle):
#			spawn_player(radius * Vector2(cos(phi), sin(phi)) + origin)
#			phi +=  2 * PI / amount_in_circle
#		radius += 30
#		amount_in_circle += 8
#		amount_of_circles -= 1
#
#func spawn_player(var position: Vector2) -> void:
#	var player = PlayerScene.instance()
#	player.get_node("KinematicBody2D").transform.origin = position
#	add_child(player)
