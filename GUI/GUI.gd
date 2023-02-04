extends Control

const RESOURCE_INCREMENT=40

onready var resource1Bar=$VBoxContainer/HBoxContainer/Resource1Bar
onready var resource2Bar=$VBoxContainer/HBoxContainer/Resource2Bar
onready var resource3Bar=$VBoxContainer/HBoxContainer/Resource3Bar
onready var tween1=$TweenResource1
onready var tween2=$TweenResource2
onready var tween3=$TweenResource3

func increaseResource1():
	resource1Bar.value+=RESOURCE_INCREMENT

func increaseResource2():
	resource2Bar.value+=RESOURCE_INCREMENT

func increaseResource3():
	resource3Bar.value+=RESOURCE_INCREMENT

