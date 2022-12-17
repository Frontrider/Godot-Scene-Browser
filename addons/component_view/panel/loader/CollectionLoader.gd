tool
extends "./FolderLoader.gd"

var extension = "tscn"

func load_collections(root):
	var files = get_dir_contents(root)

	var meshes = {}
	var collections = {}

	for file in files[0]:
		var resource_name = file.replace(root,"")
		if file.ends_with(extension):
			var resource = _load_resource(file)
			if resource != null:
				meshes[resource_name] = resource
		pass
	for file in files[1]:
		var collection_name = file.replace(root,"")
		for key in meshes:
			if key.begins_with(collection_name):
				var coll_name = collection_name.replace("/","")
				if not collections.has(coll_name):
					collections[coll_name] = []

				collections[coll_name].append({
					"name": key.replace(collection_name,"").replace("/","").replace(".%s" % extension,""),
					"scene": meshes[key],
					"collection": coll_name
				})
				pass
		pass
	return collections
	pass

#Load the obj file into a mesh.
#return null, if it was not loadable after all.
func _load_resource(resource_path):
	return null
	pass
