extends Control

const RESOURCE_INCREMENT=5
const RESOURCE_DECREASE_RATE=0.26
const FINAL_RESOURCE_INCREMENT=0.125
const MAX_FINAL_RESOURCE_VALUE=5

onready var resource1Value=100
onready var resource2Value=100
onready var resource3Value=100
onready var resource4Value=0

onready var resource1Bar=$Container/HBoxContainer/HBoxContainer/Resource1Bar
onready var resource2Bar=$Container/HBoxContainer/HBoxContainer2/Resource2Bar
onready var resource3Bar=$Container/HBoxContainer/HBoxContainer3/Resource3Bar
onready var resource4Bar=$Container/FinalResourceBar

var tutorial = false

func increaseResource1():
	resource1Value+=RESOURCE_INCREMENT
	resource1Value=min(resource1Value,100)
	resource4Value+=FINAL_RESOURCE_INCREMENT

func increaseResource2():
	resource2Value+=RESOURCE_INCREMENT
	resource2Value=min(resource2Value,100)
	resource4Value+=FINAL_RESOURCE_INCREMENT


func increaseResource3():
	resource3Value+=RESOURCE_INCREMENT
	resource3Value=min(resource3Value,100)
	resource4Value+=FINAL_RESOURCE_INCREMENT

func _ready():
	resource4Bar.max_value=MAX_FINAL_RESOURCE_VALUE

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Container/ViewportContainer.visible=true
	else:
		$Container/ViewportContainer.visible=false
	if Input.is_action_just_pressed("ui_accept"):
		pass
		#$OpenMapAudio.play()
	if Input.is_action_just_released("ui_accept"):
		pass
		#$CloseMapAudio.play()
	if not tutorial:
		resource1Value-=RESOURCE_DECREASE_RATE*delta
		resource3Value-=RESOURCE_DECREASE_RATE*delta
	
	resource2Value-=RESOURCE_DECREASE_RATE*delta
	resource1Bar.value=resource1Value if resource1Value>=0 else 0
	resource2Bar.value=resource2Value if resource2Value>=0 else 0
	resource3Bar.value=resource3Value if resource3Value>=0 else 0
	resource4Bar.value=resource4Value
	if resource1Value<=0 or resource2Value<=0 or resource3Value<=0:
		game_over()
	elif resource4Value==MAX_FINAL_RESOURCE_VALUE:
		win()

func game_over():
	print("Voce morreu")
	get_tree().change_scene("res://scenes/Starved.tscn")
	
func win():
	print("Voce venceu")
	get_tree().change_scene("res://scenes/Win.tscn")
