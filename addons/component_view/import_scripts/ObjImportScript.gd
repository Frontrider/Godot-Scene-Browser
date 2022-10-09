tool # Needed so it runs in the editor.
extends EditorScenePostImport


func post_import(scene):
	for child in scene.get_children():
		if child is MeshInstance:
			var mesh = child.mesh
			if mesh is ArrayMesh:
				if not mesh.get_faces().empty():
					child.owner = scene.owner
					return process_returned_child(child)
	return scene

func process_returned_child(child:MeshInstance):
	return child
