extends Control

func _ready():
	$Music.play()

func jogar():
	get_tree().change_scene("res://scenes/Test.tscn") 

func tutorial():
	get_tree().change_scene("res://scenes/TutorialLevel.tscn") 

func credits():
	get_tree().change_scene("res://scenes/Credits.tscn") 

func quit():
	get_tree().quit()

func load_translation(path):
	TranslationManager.load_translation(path)
