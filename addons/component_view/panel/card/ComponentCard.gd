tool
extends Control
var plugin:EditorPlugin
export var component_name = "Empty"
export var scene:PackedScene
var scene_path: NodePath
var texture = null
var selected = false

func _ready():
	hint_tooltip = component_name
	if scene == null:
		return
	if texture != null:
		$TextureRect.texture = texture
	pass


func _on_ComponentCard_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			if event.doubleclick:
				var selected = plugin.get_editor_interface().get_selection().get_selected_nodes()
				if selected.empty():
					return
				var owner_node = plugin.get_editor_interface().get_edited_scene_root()
				add_to_scene(selected[0],owner_node)
			else:
				selected(null)
	pass

func selected(zelf):
	if zelf == null:
		selected = !selected
		get_tree().call_group("element_editor_card","selected",self)
		get_tree().call_group("element_item_display","update_selection",self)
	elif zelf != self:
		selected = false
	$ColorRect.visible = selected
	pass

func searched_for(text:String):
	if text.empty():
		visible = true
	else:
		visible = component_name.to_lower().find(text) >-1

func add_to_scene(selected_node:Node,owner_node:Node):
	if selected:
		var new_node = scene.instance()
		new_node.name = component_name
		new_node.connect("tree_entered",self,"update_owner",[new_node,owner_node],CONNECT_ONESHOT)
		selected_node.call_deferred("add_child",new_node)
	pass

func update_owner(new_node,owner_node):
	new_node.owner = owner_node
	pass


func get_drag_data(position: Vector2):
	return {
		files = [scene_path],
		type = "files",
	}
