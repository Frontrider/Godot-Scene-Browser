tool
extends HFlowContainer
const Card = preload("./ComponentCard.tscn")

var plugin:EditorPlugin
export var items = []

func _ready():
	size_flags_horizontal = SIZE_EXPAND_FILL
	for item in items:
		var card = Card.instance()
		card.plugin = plugin
		card.scene = item.scene
		card.component_name = item.name
		card.name = item.name
		card.texture = item.get("icon",null)
		add_child(card)
		pass
	pass

func was_selected(items):
	if items.empty():
		visible = true
	else:
		visible = items.has(name)
	pass
