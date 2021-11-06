tool
extends Object

var default_component_image:Texture = load("res://addons/component_view/assets/default.png")

const ConfigManager = preload("res://addons/component_view/src/ConfigurationManager.gd")

var configManager:ConfigManager

func get_icon_for_component(component_name:String,category:String,scene:PackedScene):
	#print(category)
	var icon_folder = configManager.preview_folder
	if not category.empty():
		 #print("component has group "+category)
		icon_folder = icon_folder+"/"+category
		pass
	
	var icon_path = icon_folder+"/"+ component_name + ".png"
	Directory.new().make_dir_recursive(icon_folder)
	#print(icon_path)
	return get_default_icon_for_item(icon_path,scene)


func get_default_icon_for_item(icon_path: String, scene: PackedScene):
	#print("checking icon "+icon_path)
	if ResourceLoader.exists(icon_path):
		#print("icon with path "+icon_path+" exists")
		return load(icon_path)
	else:
		#print("icon not found, generation set to "+ str(configManager.generate_previews))
		if configManager.generate_previews:
			print("icon not found, generating")
			var tex = generate_icon_texture(scene)
			if tex != null:
				var img = tex.get_data()
				img.convert(Image.FORMAT_RGBA8)
				img.save_png(icon_path)
				return tex
	#print("returning default, no icon was generated")
	return default_component_image

func generate_icon_texture(scene: PackedScene):
	var instance = scene.instance()
	var mesh = find_first_mesh_in_node(instance)
	if mesh != null:
		return generate_mesh_preview(mesh)
				
func find_first_mesh_in_node(node: Node, depth: int = 0):
	var mesh = get_mesh(node)
	if mesh != null:
		return mesh
	if depth >= configManager.preview_search_depth:
		return
	for child in node.get_children():
		mesh = find_first_mesh_in_node(child, depth + 1)
		if mesh != null:
			return mesh
	
func get_mesh(node: Node):
	if ("mesh" in node and node.mesh is Mesh):
		return node.mesh
	elif (node is MultiMeshInstance and node.multimesh and node.multimesh.mesh is Mesh):
		return node.multimesh.mesh
		
func generate_mesh_preview(mesh: Mesh):
	return EditorPlugin.new().get_editor_interface().make_mesh_previews([mesh], 128)[0]
