tool
extends Node

export var root_path = "res://assets/components/"
var plugin

func load_all(plugin:EditorPlugin):
	var datas = []
	var collections = {}
	var icon_map = {}
	for child in get_children():
		var data = child.load_collections(root_path)
		#Merge the dictionaries properly.
		for key in data.keys():
			if not collections.has(key):
				collections[key] = []
			var data_array = data[key]
			
			#Map the individual items to their meshes.
			for item in data_array:
				if item.scene is PackedScene:
					var root = item.scene.instance(PackedScene.GEN_EDIT_STATE_DISABLED)
					if root is MeshInstance and plugin != null:
						icon_map[item] = root.mesh
					root.queue_free()
				
			(collections[key] as Array).append_array(data_array)
		pass
	
	var icons = plugin.get_editor_interface().make_mesh_previews(icon_map.values(),256)
	#Place all the icons into the correct items.
	for i in icon_map.keys().size():
		var item = icon_map.keys()[i]
		item["icon"] = icons[i]
	return collections
	pass
