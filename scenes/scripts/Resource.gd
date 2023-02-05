extends Area2D


const MIN_FILL_VALUE = 90
const FILL_TIME = 0.2


enum ResourceType {LIQUID, SOLID, GAS}
export (ResourceType) var resource_type


var tutorial = false


onready var gui = get_viewport().get_parent().get_node("GUI")
onready var timer = $Timer
onready var sprite = $Sprite


func _ready():
	match resource_type:
		ResourceType.SOLID:
			sprite.frame = 2
		ResourceType.LIQUID:
			sprite.frame = 0
		ResourceType.GAS:
			sprite.frame = 1


func get_resource_value():
	match resource_type:
		ResourceType.SOLID:
			return gui.resource1Value
		ResourceType.LIQUID:
			return gui.resource2Value
		ResourceType.GAS:
			return gui.resource3Value


func up_resource():
	match resource_type:
		ResourceType.SOLID:
			return gui.increaseResource1()
		ResourceType.LIQUID:
			return gui.increaseResource2()
		ResourceType.GAS:
			return gui.increaseResource3()


func try_fill(player):
	if tutorial:
		get_tree().change_scene("res://scenes/Menu.tscn")
		return
	
	if get_resource_value() < MIN_FILL_VALUE: # Can fill
		player.deactivate()
		while get_resource_value() < 100:
			timer.start(FILL_TIME)
			yield(timer, "timeout")
			up_resource()
		player.activate()
