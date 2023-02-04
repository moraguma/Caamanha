extends KinematicBody2D


const Enemy = preload("res://scenes/Banshee.tscn")


const SPEED = 80
const ACCEL = 0.1
const DECCEL = 0.3


var enemy = null
var active = true
var safe = true
var velocity = Vector2(0, 0)


onready var torso = $Torso
onready var camera = $Camera
onready var main = get_viewport().get_parent()
onready var timer = $Timer


func _physics_process(delta):
	if active:
		# Movement
		var dir = (Vector2(0, -1) * (Input.get_action_strength("move_up") - Input.get_action_strength("move_down")) + Vector2(1, 0) * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))).normalized()
		
		var accel = ACCEL
		if dir.dot(velocity) < 0:
			accel = DECCEL
		velocity = velocity.linear_interpolate(dir * SPEED, accel)
		
		velocity = move_and_slide(velocity)
		
		# Vision
		var vis_dir = main.get_global_mouse_position() - Vector2(240, 135)
		torso.rotation = Vector2(0, -1).angle_to(vis_dir)


func enter_zone(area):
	if area.get_collision_layer_bit(1): # Interagível
		pass
	elif area.get_collision_layer_bit(5): # Cenário
		safe = true
		enemy_despawn()


func exit_zone(area):
	if area.get_collision_layer_bit(1): # Interagível
		pass
	elif area.get_collision_layer_bit(5): # Cenário
		safe = false
		timer.start(main.get_enemy_spawn_time())


func enemy_spawn():
	if not safe:
		enemy = Enemy.instance()
		enemy.player = self
		
		get_viewport().add_child(enemy)


func enemy_despawn():
	if enemy != null:
		enemy.queue_free()
	
	if not safe:
		timer.start(main.get_enemy_spawn_time())


func deactivate():
	active = false


func activate():
	active = true


func die():
	print("died")
