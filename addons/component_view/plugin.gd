tool
extends EditorPlugin

const ComponentView = preload("res://addons/component_view/src/tab/ComponentView.tscn")
var view :Control
export var component_path = "res://assets/components"

func _enter_tree():
	view = ComponentView.instance()
	view.editor_plugin = self
	add_control_to_dock(DOCK_SLOT_LEFT_BL, view)
	
	var directory = Directory.new()
	if(not directory.dir_exists(component_path)):
		if not directory.dir_exists("res://assets"):
			directory.make_dir("res://assets")
		directory.make_dir(component_path)
	
	pass


func _exit_tree():
	view.queue_free()
	remove_control_from_docks(view)
	pass
