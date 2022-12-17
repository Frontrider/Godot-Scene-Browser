extends EditorScenePostImport

var scripts = []

func post_import(scene):
	for child in scene.get_children():
		if child is MeshInstance:
			var mesh = child.mesh
			if mesh is ArrayMesh:
				if not mesh.get_faces().empty():
					for script in scripts:
						child = script.post_process(child)
					return child
	return scene
