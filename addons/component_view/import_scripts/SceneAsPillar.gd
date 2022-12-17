tool # Needed so it runs in the editor.
extends "./ImportPipeline.gd"

func _init():
	scripts.append(preload("./steps/StaticCollision.gd").new())
	scripts.append(preload("./steps/ToPillar.gd").new())

