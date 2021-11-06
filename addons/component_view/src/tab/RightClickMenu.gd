tool
extends PopupMenu

export(Array,Resource) var context_menu_items = []
var editor_plugin

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var id = 0
	clear()
	for item in context_menu_items:
		if item.has_check:
			add_check_item(item.item_name,id)
		else:
			add_item(item.item_name,id)
		id+=1
	pass

var currently_selected:int =0

func _on_RightClickMenu_id_pressed(id):
	
	var item = context_menu_items[id]
	print(item.item_index)
	match item.item_index:
		0:
			toggle_item_checked(id)
			pass
		1:
			var current_item = get_parent().get_item_by_index(currently_selected)
			get_parent().editor_plugin.edit_scene(current_item.scene)
			pass
		3:
			get_parent().place_component(currently_selected)
			pass
	pass # Replace with function body.


func _on_Components_show_menu(index, position):
	self.margin_left = position.x
	self.margin_top = position.y+rect_size.y
	currently_selected = index
	popup()
	pass # Replace with function body.
