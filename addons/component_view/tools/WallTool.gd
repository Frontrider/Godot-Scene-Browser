tool
extends Spatial

export var width = 1
export var heigth = 1


func _ready():
	pass


func set_width(new):
	width = new

func set_heigth(new):
	heigth = new


func update_wall():
	for child in get_children():
		if child.has_meta("dynamic"):
			child.call_deferred("queue_free")
		pass

	pass
