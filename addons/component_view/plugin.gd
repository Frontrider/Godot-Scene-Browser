tool
extends EditorPlugin

const ComponentView = preload("res://addons/component_view/src/tab/ComponentView.tscn")
var view :Control

export var component_path = "res://assets/components"
var component_path_properties_name = "component_view/components_path"

var generate_previews = false
var auto_generate_previews_properties_name = "component_view/auto_generate_previews"

var preview_folder = "res://.component_view/previews"
var preview_folder_properties_name = "component_view/previews_folder"

func _enter_tree():
	view = ComponentView.instance()
	if(!ProjectSettings.has_setting(auto_generate_previews_properties_name)):
		ProjectSettings.set_setting(auto_generate_previews_properties_name,generate_previews)
		print("creating component view setting: "+auto_generate_previews_properties_name)
		
	if(!ProjectSettings.has_setting(preview_folder_properties_name)):
		ProjectSettings.set_setting(preview_folder_properties_name,preview_folder)
		print("creating component view setting: "+preview_folder_properties_name)
		
		var property_info = {
			"name": preview_folder_properties_name,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_DIR
		}
		ProjectSettings.add_property_info(property_info)
		
	if(!ProjectSettings.has_setting(component_path_properties_name)):
		ProjectSettings.set_setting(component_path_properties_name,component_path)
		print("creating component view setting: "+component_path_properties_name)
		var property_info = {
			"name": component_path_properties_name,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_DIR
		}
		ProjectSettings.add_property_info(property_info)
		
	ProjectSettings.save()
	var directory = Directory.new()
	directory.make_dir_recursive(component_path)
	directory.make_dir_recursive(preview_folder)
	
	view.editor_plugin = self
	add_control_to_dock(DOCK_SLOT_LEFT_BL, view)
	pass


func _exit_tree():
	view.queue_free()
	remove_control_from_docks(view)
	
	pass
