extends KinematicBody2D


const SPAWN_DISTANCE = 600
const DESPAWN_DISTANCE = 750
const CHASE_BASE_DISTANCE = 64
const CHASE_MAX_ANGLE = PI/12

const MAX_MOVE_ANGLE = PI/12
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


onready var noise = OpenSimplexNoise.new()
onready var raycast = $Raycast


func _ready():
	if player == null:
		print("Player not set!")
		queue_free()
	else:
		noise.seed = randi()
		noise.octaves = 4
		noise.period = 20.0
		
		print("Spawned enemy")
		position = player.position + Vector2(0, -1).rotated(rand_range(-PI, PI)) * SPAWN_DISTANCE
		dir = ((player.position + player.velocity.normalized() * CHASE_BASE_DISTANCE - position).rotated(rand_range(-CHASE_MAX_ANGLE, CHASE_MAX_ANGLE))).normalized()
		
		velocity = dir * SPEED


func _physics_process(delta):
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
		chase = true
