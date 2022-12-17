#Takes in up to 4 scenes (top,mid,bottom,single) and creates a stack from them
#Useful for pillars and walls.
tool
extends Spatial
class_name StairTool, "../assets/pillar.png"

export(float) var bottom_height = 0.0
export(float) var mid_height = 0.0

export(int) var full_height = 1 setget set_height

export(PackedScene) var bottom
export(PackedScene) var middle
export(PackedScene) var top
export(PackedScene) var single

func _ready():
	if(get_child_count() == 0):
		set_height(full_height)
	pass

func set_height(new):
	full_height = new
	for child in get_children():
		if child.has_meta("dynamic"):
			child.call_deferred("queue_free")
		pass
	var offset = 0
	if full_height == 1:
		var child = single.instance() as Node
		child.set_meta("dynamic",true)
		child.connect("ready",self,"set_child_owner",[child],CONNECT_ONESHOT)
		add_child(child)

	elif full_height > 1:
		var child = bottom.instance() as Spatial
		child.set_meta("dynamic",true)
		child.connect("ready",self,"set_child_owner",[child],CONNECT_ONESHOT)
		add_child(child)
		offset += bottom_height

		if full_height-2>0:
			for i in full_height-2:
				var mid_child = top.instance() as Spatial
				mid_child.set_meta("dynamic",true)
				mid_child.transform.origin.y = offset
				mid_child.connect("ready",self,"set_child_owner",[mid_child],CONNECT_ONESHOT)
				add_child(mid_child)
				offset += mid_height
				pass
			pass

		var top_child = top.instance() as Spatial
		top_child.set_meta("dynamic",true)
		top_child.transform.origin.y = offset
		top_child.connect("ready",self,"set_child_owner",[top_child],CONNECT_ONESHOT)
		add_child(top_child)


func set_child_owner(child):
	child.owner = owner
	pass
