extends Node

var numOfSB = 0

func save():
	var saveFile = File.new()
	saveFile.open("user://save.save", File.WRITE)
	for i in get_tree().get_nodes_in_group('persist'):
		var dict = i.save()
		saveFile.store_line(to_json(dict))
	saveFile.store_line(to_json(plVars.vars))
	saveFile.store_line(to_json(upgrades.vars))
	saveFile.store_line(to_json(upgrades.costs))
	saveFile.close()



func _load():
	var saveFile = File.new()
	saveFile.open("user://save.save", File.READ)
	while saveFile.get_position() < saveFile.get_len():
		var dict = parse_json(saveFile.get_line())
		if !dict.has('energy') and !dict.has('shipHealthCost') and !dict.has('shipHealthLvl'):
			var obj = load(dict["filename"]).instance()
			get_node(dict["parent"]).add_child(obj)
			obj.position = Vector2(dict["pos_x"], dict["pos_y"])
			obj.name = dict.Name
			
			for i in dict.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == 'Name':
					continue
				obj.set(i, dict[i])
		elif dict.has('energy'):
			plVars.vars = dict
		elif dict.has('shipHealthCost'):
			upgrades.costs = dict
		elif dict.has('shipHealthLvl'):
			upgrades.vars = dict
		
	saveFile.close()
	get_parent().get_node('Main').get_node('Controls').get_node('reloadTime').start()
