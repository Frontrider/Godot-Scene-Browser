tool
extends Panel

func update_selection(item):
	var item_name = item.component_name
	var collection_name = item.get_parent().name
	
	$"%NameLabel".text = item_name
	$"%CollectionLabel".text = collection_name
	pass
