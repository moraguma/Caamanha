extends RichTextLabel


export var code: String


func _ready():
	bbcode_enabled = true
	add_to_group("Translatables")
	update_translation()


func update_translation():
	if code != "":
		bbcode_text = "[center]" + TranslationManager.get_translation(code)
