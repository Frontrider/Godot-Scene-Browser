tool
extends Button
var plugin:EditorPlugin
func _ready():
	pass # Replace with function body.

func _on_AddToSceneButton_pressed():

	var selected = plugin.get_editor_interface().get_selection().get_selected_nodes()
	if selected.empty():
		return
	var owner_node = plugin.get_editor_interface().get_edited_scene_root()
	get_tree().call_group("element_editor_card","add_to_scene",selected[0],owner_node)
	pass
