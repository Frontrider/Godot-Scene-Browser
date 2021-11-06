extends Object

export var component_path = "res://assets/components"
var component_path_properties_name = "component_view/components_path"

var generate_previews = false
var auto_generate_previews_properties_name = "component_view/auto_generate_previews"

var preview_folder = "res://.component_view/previews"
var preview_folder_properties_name = "component_view/previews_folder"

var component_setting_folder = "res://.component_view/component_settings"
var component_setting_folder_properties_name = "component_view/component_settings"

var preview_search_depth = 3
var preview_search_depth_properties_name = "component_view/preview_search_depth"

func init_settings():
	if(!ProjectSettings.has_setting(auto_generate_previews_properties_name)):
		ProjectSettings.set_setting(auto_generate_previews_properties_name,generate_previews)
		print("creating component view setting: "+auto_generate_previews_properties_name)
	generate_previews = ProjectSettings.get(auto_generate_previews_properties_name)
	preview_folder = create_directory_setting(preview_folder_properties_name,preview_folder)
	component_setting_folder =  create_directory_setting(component_setting_folder_properties_name,component_setting_folder)
	component_path = create_directory_setting(component_path_properties_name,component_path)
	preview_search_depth = create_int_setting(preview_search_depth_properties_name,preview_search_depth)
	
	ProjectSettings.save()
	var directory = Directory.new()
	directory.make_dir_recursive(component_path)
	directory.make_dir_recursive(preview_folder)
	directory.make_dir_recursive(component_setting_folder)
	pass

func create_directory_setting(name,default_value):
	if(!ProjectSettings.has_setting(name)):
		ProjectSettings.set_setting(name,default_value)
		print("creating component view setting: "+name)
		
		var property_info = {
			"name": name,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_DIR
		}
		ProjectSettings.add_property_info(property_info)
	return ProjectSettings.get_setting(name)

func create_int_setting(name,default_value):
	if(!ProjectSettings.has_setting(name)):
		ProjectSettings.set_setting(name,default_value)
		print("creating component view setting: "+name)
		
		var property_info = {
			"name": name,
			"type": TYPE_INT,
		}
		ProjectSettings.add_property_info(property_info)
	return ProjectSettings.get_setting(name)


func get_config_for_component(component_name:String,group:String):
	
	pass

