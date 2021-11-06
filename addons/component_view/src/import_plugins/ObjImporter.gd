extends "res://addons/component_view/src/ComponentImportPlugin.gd"
#import obj files and packs them into a component scene.

func matches_type(path:String):
	return path.ends_with(".obj")
	
func import(path:String)->PackedScene:
	var mesh = ResourceLoader.load(path,"Mesh")
	var meshInstance = MeshInstance.new()
	meshInstance.mesh = mesh
	var scene = PackedScene.new()
	scene.pack(meshInstance)
	return scene
	pass
