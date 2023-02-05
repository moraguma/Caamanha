extends Node2D


const JUMPSCARE_TIME = 4
const MIN_SPAWN_TIME = 0.5
const MAX_SPAWN_TIME = 7


export (bool) var tutorial = false


onready var gui = $GUI
onready var jumpscare = get_node_or_null("Jumpscare")
onready var timer = get_node_or_null("Timer")
var time = 0


func _ready():
	if tutorial:
		$Viewport/Nivel/ResourceLiquid.tutorial = tutorial
		gui.tutorial = tutorial


func _process(delta):
	if not tutorial:
		time += delta
		
		jumpscare.offset = 20 * Vector2(sin(time * 2 * PI * 4), cos(time * 2 * PI * 3))


func get_enemy_spawn_time():
	if tutorial:
		return 999999999999
	return MAX_SPAWN_TIME - (MAX_SPAWN_TIME - MIN_SPAWN_TIME) * gui.resource4Value / gui.MAX_FINAL_RESOURCE_VALUE


func to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")


func jumpscare():
	if not tutorial:
		jumpscare.show()
		timer.start(JUMPSCARE_TIME)
		yield(timer, "timeout")
		to_menu()
