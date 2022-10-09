tool # Needed so it runs in the editor.
extends "res://addons/component_view/import_scripts/ObjImportScript.gd"

func process_returned_child(child:MeshInstance):
	var shape = child.mesh.create_trimesh_shape()
	var collider = CollisionShape.new()
	collider.shape = shape
	var body = StaticBody.new()
	body.name = "StaticBody"
	collider.name = "CollisionShape"
	body.add_child(collider)
	child.add_child(body)
	body.owner = child
	collider.owner = child
	return child
	pass
