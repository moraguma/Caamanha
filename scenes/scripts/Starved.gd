extends Node2D


const RESTART_TIME = 5


onready var timer = $Timer


func _ready():
	timer.start(RESTART_TIME)
	yield(timer, "timeout")
	get_tree().change_scene("res://scenes/Menu.tscn")
