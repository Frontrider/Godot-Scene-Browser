tool
extends "./CollectionLoader.gd"

func _ready():
	extension = "glb"
	pass

#Load the scene file.
func _load_resource(resource_path):
	return load(resource_path)
	pass
