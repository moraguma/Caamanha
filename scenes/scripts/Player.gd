extends KinematicBody2D


const Enemy = preload("res://scenes/Banshee.tscn")


const SPEED = 70
const ACCEL = 0.1
const DECCEL = 0.3
const MIN_MOVE_SPEED = 5


var enemy = null
var active = true
var safe = true
var velocity = Vector2(0, 0)
var time = 0


onready var torso = $Torso
onready var legs = $Legs
onready var camera = $Camera
onready var main = get_viewport().get_parent()
onready var timer = $Timer
onready var animation_player = $AnimationPlayer


func _physics_process(delta):
	if active:
		# Movement
		var dir = (Vector2(0, -1) * (Input.get_action_strength("move_up") - Input.get_action_strength("move_down")) + Vector2(1, 0) * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))).normalized()
		
		var accel = ACCEL
		if dir.dot(velocity) < 0:
			accel = DECCEL
		velocity = velocity.linear_interpolate(dir * SPEED, accel)
		
		velocity = move_and_slide(velocity)
		
		if velocity.distance_to(Vector2(0, 0)) > MIN_MOVE_SPEED:
			animation_player.play("move")
			legs.rotation = Vector2(0, -1).angle_to(velocity)
		else:
			animation_player.play("idle")
		
		# Vision
		var vis_dir = main.get_global_mouse_position() - Vector2(240, 135)
		torso.rotation = Vector2(0, -1).angle_to(vis_dir)


func enter_zone(area):
	if area.get_collision_layer_bit(1): # Interagível
		area.try_fill(self)
	elif area.get_collision_layer_bit(5): # Cenário
		safe = true
		timer.stop()
		enemy_despawn()


func exit_zone(area):
	if area.get_collision_layer_bit(5): # Cenário
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
		enemy = null
	
	if not safe:
		timer.start(main.get_enemy_spawn_time())


func deactivate():
	active = false


func activate():
	active = true


func die():
	active = false
	main.jumpscare()
