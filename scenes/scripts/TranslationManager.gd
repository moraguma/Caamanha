extends Node


var translation


func _ready():
	translation = load("res://resources/translations/en.gd").new()


func load_translation(path: String):
	translation = load(path).new()
	get_tree().call_deferred("call_group", "Translatables", "update_translation")


func get_translation(code: String):
	return translation.translations[code]

