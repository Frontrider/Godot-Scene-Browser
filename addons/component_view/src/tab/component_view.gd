tool
extends Control

var ComponentManager = preload("res://addons/component_view/src/ComponentManager.gd")

var componentManager = ComponentManager.new()

var editor_plugin
var search_term = ""

var search_in_all = false
var component_path = "res://assets/components/"

var scene_cache = {}

signal show_menu(index,position)

onready var popup = $RightClickMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	componentManager.editor_plugin = editor_plugin
	componentManager.init()
	
	component_path = ProjectSettings.get(editor_plugin.configManager.component_path_properties_name)+"/"
	#print(preview_path)
	#print(component_path)
	update_categories()
	pass

func get_scene_for(item_name):
	if not scene_cache.has(item_name):
		scene_cache[item_name] = load(component_path + item_name + ".tscn")
		pass
	return scene_cache[item_name]
	pass

func get_item_by_index(index):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	var component_name = item_list.get_item_text(index)
	return componentManager.items[component_name]
	pass


func update_categories():
	#print("cleaning categories")
	componentManager.clear()
	componentManager.load_components()
	var category_list = $VBoxContainer2/VBoxContainer/CategoryMenu/CategoryList
	category_list.clear()
	
	for key in componentManager.categories.keys():
		category_list.add_item(key)
	
	_on_CategoryList_item_selected(0)
	pass

func is_blank(text:String):
	var searched = text.replace(" ","")
	searched = searched.replace("	","")
	#print(searched.length())
	return searched.length()==0
	pass

func _on_UpdateCategoriesButton_pressed():
	update_categories()
	pass

func _on_SearchButton_pressed():
	var search_text_box = $VBoxContainer2/VBoxContainer/SearchMenu/TextEdit
	var search_all_checkbox = $VBoxContainer2/VBoxContainer/SearchMenu/SearchInAll
	search_term = search_text_box.text
	if(is_blank(search_term)):
		var category_list = $VBoxContainer2/VBoxContainer/CategoryMenu/CategoryList
		var selected = category_list.selected
		_on_CategoryList_item_selected(selected)
		pass
	var results = []
	var search_in = []
	
	if(search_all_checkbox.pressed):
		search_in.append_array(componentManager.items.values())
		pass
	else:
		var category_list = $VBoxContainer2/VBoxContainer/CategoryMenu/CategoryList
		var index = category_list.selected
		var category = category_list.get_item_text(index)
		for item_name in componentManager.categories[category]:
			search_in.append(componentManager.items[item_name])
		pass
	#print(search_in)
	for item in search_in:
		if (item.name as String).find(search_term)>-1:
			results.append(item)
			pass

	_update_item_list(results)
	pass

func _on_SearchInAll_toggled(button_pressed):
	search_in_all = button_pressed
	pass 


func _on_CategoryList_item_selected(index):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	var category_list = $VBoxContainer2/VBoxContainer/CategoryMenu/CategoryList
	var category = category_list.get_item_text(index)
	#print(category)
	#print(categories)
	var results = []
	for item in componentManager.categories[category]:
		var item_data = componentManager.items[item]
		results.append(item_data)
		pass
	_update_item_list(results)
	pass 

func _update_item_list(items:Array):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	item_list.clear()
	for item in items:
		item_list.add_item(item.name,item.icon)
		pass
	pass

func _on_ItemList_item_activated(index):
	place_component(index)
	pass 

func place_component(index = -1):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	var item = item_list.get_item_text(index)
	
	var root = editor_plugin.get_edited_root()
	#print(root)
	if root == null :
		return
	componentManager.place_component_under(root,item)
	pass

#we want to store the selected component for replaces and alike.
func _on_ItemList_item_selected(index):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	var item = item_list.get_item_text(index)
	#print(componentManager.items)
	var item_scene = componentManager.items[item].scene
	editor_plugin.pluginState.selectedComponentScene = item_scene


func _on_ItemList_item_rmb_selected(index, at_position):
	var item_list = $VBoxContainer2/ScrollContainer/ItemList
	var global_pos = $VBoxContainer2/ScrollContainer/ItemList/Node2D.to_global(at_position)
	emit_signal("show_menu",index,global_pos)
	pass # Replace with function body.
