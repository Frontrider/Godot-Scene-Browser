tool
extends "../ImportStep.gd"

func post_process(child:Spatial):
	var pillar_tool = PillarTool.new()
	var height = child.mesh.get_aabb().size.y
	var scene = PackedScene.new()

	for children in child.get_children():
		children.owner = child

	scene.pack(child)
	pillar_tool.bottom_height = height
	pillar_tool.mid_height = height
	pillar_tool.bottom = scene
	pillar_tool.middle = scene
	pillar_tool.top = scene
	pillar_tool.single = scene
	pillar_tool.set_meta("_edit_group_",true)
	child.queue_free()
	return pillar_tool
