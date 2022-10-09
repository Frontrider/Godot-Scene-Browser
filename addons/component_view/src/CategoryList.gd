tool
extends ItemList

signal selection_finished(array)

func _ready():
	connect("nothing_selected",self,"selected")
	connect("item_selected",self,"item_selected")
	connect("multi_selected",self,"multi_selected")
	pass

func selected():
	var selected = []
	for index in get_selected_items():
		selected.append(get_item_text(index))
		pass
	emit_signal("selection_finished",selected)
	pass

func item_selected(index):
	selected()
	pass

func multi_selected(index,selected):
	selected()
	pass
