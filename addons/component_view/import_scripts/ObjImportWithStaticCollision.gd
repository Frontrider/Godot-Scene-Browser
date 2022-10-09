tool # Needed so it runs in the editor.
extends "res://addons/component_view/import_scripts/ObjImportScript.gd"

func process_returned_child(child:MeshInstance):
	var shape = child.mesh.create_convex_shape()
	var collider = CollisionShape.new()
	collider.shape = shape
	var body = StaticBody.new()
	body.owner = child
	collider.owner = child
	body.call_deferred("add_child",collider)
	child.call_deferred("add_child",body)
	return child
	pass
