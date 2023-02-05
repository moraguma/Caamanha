extends Node2D


const MIN_SPAWN_TIME = 0.5
const MAX_SPAWN_TIME = 7


onready var gui = $GUI


func get_enemy_spawn_time():
	return MAX_SPAWN_TIME - (MAX_SPAWN_TIME - MIN_SPAWN_TIME) * gui.resource4Value / gui.MAX_FINAL_RESOURCE_VALUE
