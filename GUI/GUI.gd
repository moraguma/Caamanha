extends Control

const RESOURCE_INCREMENT=40
const RESOURCE_DECREASE_RATE=0.5

onready var resource1Value=100
onready var resource2Value=100
onready var resource3Value=100

onready var pending_increase1=false
onready var pending_increase2=false
onready var pending_increase3=false

onready var resource1Bar=$VBoxContainer/HBoxContainer/Resource1Bar
onready var resource2Bar=$VBoxContainer/HBoxContainer/Resource2Bar
onready var resource3Bar=$VBoxContainer/HBoxContainer/Resource3Bar

onready var tween1=$TweenResource1
onready var tween2=$TweenResource2
onready var tween3=$TweenResource3

func increaseResource1():
	pending_increase1=true

func increaseResource2():
	pending_increase2=true

func increaseResource3():
	pending_increase3=true

func _ready():
	tween1.interpolate_property(self,"resource1Value",resource1Value,resource1Value-RESOURCE_DECREASE_RATE,0.1)
	tween1.start()
	tween2.interpolate_property(self,"resource2Value",resource2Value,resource2Value-RESOURCE_DECREASE_RATE,0.1)
	tween2.start()
	tween3.interpolate_property(self,"resource3Value",resource3Value,resource3Value-RESOURCE_DECREASE_RATE,0.1)
	tween3.start()
	
func _process(delta):
	resource1Bar.value=resource1Value
	resource2Bar.value=resource2Value
	resource3Bar.value=resource3Value

func _on_TweenResource1_tween_completed(object, key):
	if pending_increase1:
		pending_increase1=false
		resource1Value+=RESOURCE_INCREMENT
	tween1.start()



func _on_TweenResource2_tween_completed(object, key):
	if pending_increase2:
		pending_increase2=false
		resource2Value+=RESOURCE_INCREMENT
	tween2.start()


func _on_TweenResource3_tween_completed(object, key):
	if pending_increase3:
		pending_increase3=false
		resource3Value+=RESOURCE_INCREMENT
	tween3.start()
