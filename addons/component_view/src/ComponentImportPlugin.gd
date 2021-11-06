extends Object

func matches_type(path:String):
	return false


func import(path:String)->PackedScene:
	
	var scene = PackedScene.new()
	scene.pack(Spatial.new())
	return scene
	#reference for saving
	#ResourceSaver.save(component_path,scene,ResourceSaver.FLAG_CHANGE_PATH|ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS)
	pass
