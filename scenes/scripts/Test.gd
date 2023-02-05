extends Node2D


const MIN_SPAWN_TIME = 0.5
const MAX_SPAWN_TIME = 7


export (bool) var tutorial = false


onready var gui = $GUI


func _ready():
	if tutorial:
		$Viewport/Nivel/ResourceLiquid.tutorial = tutorial
		gui.tutorial = tutorial


func get_enemy_spawn_time():
	if tutorial:
		return 999999999999
	return MAX_SPAWN_TIME - (MAX_SPAWN_TIME - MIN_SPAWN_TIME) * gui.resource4Value / gui.MAX_FINAL_RESOURCE_VALUE


func to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")
