tool
extends "./CollectionLoader.gd"

func _ready():
	extension = "obj"
	pass

#Load an obj file, and pack it into a scene.
func _load_resource(resource_path):
	return load(resource_path)
	pass
