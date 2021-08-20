extends Node2D

func _ready():
	add_to_group('persist')



func _process(delta):
	$'CanvasLayer/shipHealth'.set_max(plVars.vars.shipMaxHealth)
	$'CanvasLayer/shipHealth'.set_value(plVars.vars.shipHealth)
	$'CanvasLayer/energy'.set_text('E' + str(plVars.vars.energy))
	$'CanvasLayer/shipFuel'.set_max(plVars.vars.shipMaxFuel)
	$'CanvasLayer/shipFuel'.set_value(plVars.vars.shipFuel)
	$'CanvasLayer/shipHealth'.set_max(plVars.vars.shipMaxHealth)
	$'CanvasLayer/shipHealth'.set_value(plVars.vars.shipHealth)



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict
