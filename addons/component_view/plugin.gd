tool
extends EditorPlugin

const ConfigManager = preload("res://addons/component_view/src/ConfigurationManager.gd")

var configManager = ConfigManager.new()

const EditorPluginState = preload("res://addons/component_view/src/EditorPluginState.gd")
var pluginState = EditorPluginState.new()

const ComponentView = preload("res://addons/component_view/src/tab/ComponentView.tscn")
var view :Control
const ToolbarView = preload("res://addons/component_view/src/toolbar/ComponentViewToolbar.tscn")
var toolBarView:Control


var eds = get_editor_interface().get_selection()

signal selection_changed(node)

func _enter_tree():
	eds.connect("selection_changed", self, "_on_selection_changed")
	configManager.init_settings()
	
	view = ComponentView.instance()
	toolBarView = ToolbarView.instance()
	view.editor_plugin = self
	toolBarView.editor_plugin = self
	add_control_to_dock(DOCK_SLOT_LEFT_BL, view)
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU,toolBarView)
	pass

func _exit_tree():
	
	remove_control_from_docks(view)
	view.queue_free()
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU,toolBarView)
	toolBarView.queue_free()
	pass


func get_edited_root() -> Node:
	var eds = get_editor_interface().get_selection()
	var selected = eds.get_selected_nodes()
	#print(selected)
	if selected.size():
		return selected[0]
	return null

func _on_selection_changed():
	# Returns an array of selected nodes
	var selected = eds.get_selected_nodes() 
	#print(selected)
	#we only select 1 node, any other case is invalid.
	if selected.size() ==1:
		var selected_node = selected[0]
		emit_signal("selection_changed",selected_node)
	else:
		emit_signal("selection_changed",null)

func edit_scene(object:PackedScene):
	get_editor_interface().open_scene_from_path(object.resource_path)

	
