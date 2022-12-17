tool
extends "../ImportStep.gd"

func post_process(child:Spatial):
	var shape = child.mesh.create_convex_shape()
	var collider = CollisionShape.new()
	collider.shape = shape
	var body = StaticBody.new()
	body.add_child(collider)
	child.add_child(body)
	body.owner = child
	collider.owner = child
	return child
