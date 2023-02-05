extends Control

func _ready():
	pass

func _on_Jogar_pressed():
	get_tree().change_scene("res://scenes/Test.tscn") 

func _on_Creditos_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
	
func _on_Sair_pressed():
	get_tree().quit()

func _on_Tutorial_pressed():
	get_tree().change_scene("res://scenes/TutorialLevel.tscn")
