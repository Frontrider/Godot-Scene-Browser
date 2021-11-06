tool
extends Object

var PreviewGenerator = preload("res://addons/component_view/src/PreviewGenerator.gd")

var previewGenerator = PreviewGenerator.new()

var editor_plugin

var items = {}
var categories = {}

var component_path = "res://assets/components/"

func init():
	component_path = ProjectSettings.get(editor_plugin.configManager.component_path_properties_name)+"/"
	previewGenerator.configManager = editor_plugin.configManager
	pass
	
func load_components():
	_get_components_in_directory(component_path,"")
	var results = _get_in_directory(component_path,["tscn","scn"],[])
	print(results)
	pass

func clear():
	items.clear()
	categories.clear()
	pass


func _get_components_in_directory(path,category=""):
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	#print("opened "+path)
	while true:
		var file = dir.get_next()
		#print(file)
		if file == "":
			break
		elif not file.begins_with(".") :
			if file.ends_with(".tscn"):
				#print("added as scene")
				#print(file)
				#print(category)
				_add_item(path,file,category)
				pass
			elif file.count(".") == 0 and category.length() == 0:
				#print("added as category")
				#print(file)
				_get_components_in_directory(path + "/" + file,file)
				pass
	dir.list_dir_end()
	pass

func _get_in_directory(path,extensions:Array,collection=[]):
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") :
			for extension in extensions:
				if file.ends_with("."+extension):
					collection.push_back(path+"/"+file)
					pass
				else:
					_get_in_directory(path + "/" + file,extensions,collection)
					pass
			pass
	dir.list_dir_end()
	return collection

func _add_item(path:String,component_file,category):
	var component_name= component_file.split(".")[0]
	var component_scene_path = path + "/" + component_name + ".tscn"
	var scene: PackedScene = load(component_scene_path)
	var icon: Texture = previewGenerator.get_icon_for_component(component_name,category, scene)
	
	items[component_name]= {
		"name" : component_name,
		"icon" : icon,
		"scene" : scene,
	}
	
	if(category.length()==0):
		category = "ungrouped"
	#print(category)
	add_item_to_category(category,component_name)
	pass

func add_item_to_category(category,component_name):
	if not categories.has(category):
		categories[category] = []
	categories[category].append(component_name)
	pass


func place_component_under(root:Node,component_name:String):
	var item_instance = items[component_name].scene.instance()
	item_instance.name = component_name
	
	root.add_child(item_instance)
	item_instance.set_owner(root.get_tree().get_edited_scene_root())
	pass
