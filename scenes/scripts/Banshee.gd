extends KinematicBody2D

const Sounds = preload("res://scenes/BansheeSounds.tscn")

const SOUND_BASE_TIMER = 6.5
const SOUND_TIMER_VAR = 2

const LIVING_TIME = 16
const SPAWN_DISTANCE = 400
const DESPAWN_DISTANCE = 500
const CHASE_BASE_DISTANCE = 2
const CHASE_MAX_ANGLE = PI/24

const MAX_MOVE_ANGLE = PI/12
const START_SPEED = 400
const SPEED = 70
const CHASE_SPEED = 100
const CHASE_DISTANCE = 90
const ACCEL = 0.03


var chase = false
var player = null
var velocity = Vector2(0, 0)
var dir = Vector2(0, 0)
var trees = []
var time = 0
var sounds
var sound_timer


onready var noise = OpenSimplexNoise.new()
onready var raycast = $Raycast
onready var timer = $Timer


func _ready():
	if player == null:
		print("Player not set!")
		queue_free()
	else:
		sounds = Sounds.instance()
		sound_timer = sounds.get_node("SoundTimer")
		get_viewport().get_parent().add_child(sounds)
		sounds.position = Vector2(240, 135) + position - player.position
		
		play_sound()
		sounds.get_node("move_" + str(randi() % 2 + 1)).play()
		$AnimationPlayer.play("move")
		
		noise.seed = randi()
		noise.octaves = 4
		noise.period = 20.0
		
		print("Spawned enemy")
		position = player.position + Vector2(0, -1).rotated(rand_range(-PI, PI)) * SPAWN_DISTANCE
		dir = ((player.position + player.velocity * CHASE_BASE_DISTANCE - position).rotated(rand_range(-CHASE_MAX_ANGLE, CHASE_MAX_ANGLE))).normalized()
		
		velocity = dir * START_SPEED
		
		timer.start(LIVING_TIME)
		yield(timer, "timeout")
		if not chase:
			player.enemy_despawn()


func _physics_process(delta):
	sounds.position = Vector2(240, 135) + position - player.position
	
	time += delta
	
	var current_dir
	var speed
	
	if chase:
		current_dir = (player.position - position).normalized()
		speed = CHASE_SPEED
	else:
		current_dir = dir
		speed = SPEED
		
		for tree in trees:
			current_dir += (position - tree.position).normalized()
		current_dir.normalized()
		current_dir = current_dir.rotated(noise.get_noise_1d(time) * MAX_MOVE_ANGLE)
	
	velocity = velocity.linear_interpolate(current_dir * speed, ACCEL)
	move_and_slide(velocity)
	
	rotation = Vector2(0, -1).angle_to(velocity)
	
	if position.distance_to(player.position) > DESPAWN_DISTANCE: # Despawn
		player.enemy_despawn()


func object_entered(area):
	if area.get_collision_layer_bit(0):
		player.die()
	else:
		trees.append(area.get_parent())
		if area.get_collision_layer_bit(4):
			position += dir * 48


func object_exited(area):
	trees.erase(area.get_parent())


func see_player(area):
	raycast.cast_to = player.position - position
	raycast.force_raycast_update()
	if not raycast.is_colliding():
		print("Chasing")
		sounds.get_node("chase").play()
		chase = true


func play_sound():
	sound_timer.start(SOUND_BASE_TIMER + rand_range(-SOUND_TIMER_VAR, SOUND_TIMER_VAR))
	
	sounds.get_node("noise_" + str(randi() % 6 + 1)).play()
