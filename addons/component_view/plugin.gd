tool
extends EditorPlugin

const ComponentView = preload("res://addons/component_view/panel/ComponentView.tscn")
var view :Control
export var component_path = "res://assets/components/"

func _enter_tree():
	view = ComponentView.instance()
	view.plugin = self
	add_control_to_bottom_panel(view,"Scene Browser")

	var directory = Directory.new()
	if(not directory.dir_exists(component_path)):
		if not directory.dir_exists("res://assets"):
			directory.make_dir("res://assets")
		directory.make_dir(component_path)

	pass


func _exit_tree():
	remove_control_from_bottom_panel(view)
	view.queue_free()
	pass
