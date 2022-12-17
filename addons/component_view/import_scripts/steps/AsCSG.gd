tool
extends "../ImportStep.gd"


func post_process(child:Spatial):
	var csg = CSGMesh.new()
	csg.mesh = child.mesh
	child.queue_free()
	return csg
