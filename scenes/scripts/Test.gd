extends Node2D


const ALUCIN_TIME_BASE = 15
const ALUCIN_TIME_MOD = 5
const JUMPSCARE_TIME = 4
const MIN_SPAWN_TIME = 0.5
const MAX_SPAWN_TIME = 7
const SOUND_DISTANCE_MIN = 100
const SOUND_DISTANCE_MAX = 300


export (bool) var tutorial = false


onready var sound_timer = $Sounds/SoundTimer
onready var player = $Viewport/Player
onready var gui = $GUI
onready var jumpscare = get_node_or_null("Jumpscare")
onready var timer = get_node_or_null("Timer")
var time = 0


func _ready():
	play_alucination()
	
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


func play_alucination():
	sound_timer.start(ALUCIN_TIME_BASE + rand_range(-ALUCIN_TIME_MOD, ALUCIN_TIME_MOD))
	
	if not player.safe:
		var s = get_node("Sounds/Alucin" + str(randi() % 10 + 1))
		s.position = Vector2(0, rand_range(SOUND_DISTANCE_MIN, SOUND_DISTANCE_MAX)).rotated(rand_range(-PI, PI)) + Vector2(240, 135)
		s.play() 
