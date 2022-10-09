tool
extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_SearchText_text_changed(new_text):
	get_tree().call_group("element_editor_card","searched_for",new_text.to_lower())
	pass # Replace with function body.
