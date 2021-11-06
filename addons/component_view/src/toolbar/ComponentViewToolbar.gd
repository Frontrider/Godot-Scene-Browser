tool
extends Control

var editor_plugin:EditorPlugin

onready var popupMenu = $MenuButton

# Called when the node enters the scene tree for the first time.
func _ready():
	popupMenu.get_popup().connect("id_pressed", self, "_on_item_pressed")
	editor_plugin.connect("selection_changed", self, "_on_selection_changed")
	visible = false
	pass # Replace with function body.

func _on_selection_changed(selected_node:Node):
	#if the selection is null, or not a scene hide the button.
	#print(selected_node)
	if(selected_node ==null):
		visible = false
	else:
		visible = selected_node.filename != ""
	pass

func _on_item_pressed(ID):
	match(ID):
		0:
			#print("replacing the selected scene")
			var component_scene = editor_plugin.pluginState.selectedComponentScene
			var root = editor_plugin.get_edited_root()
			if root == null :
				return
			if component_scene == null:
				return
			var item_instance = component_scene.instance()
			root.get_parent().add_child(item_instance)
			var children = root.get_children()
			item_instance.transform = root.transform
			item_instance.set_owner(root.get_tree().get_edited_scene_root())
			for child in children:
				if(child.owner != root):
					root.remove_child(child)
					item_instance.add_child(child)
					child.set_owner(item_instance.get_tree().get_edited_scene_root())
				pass
			root.queue_free()
	
	pass
