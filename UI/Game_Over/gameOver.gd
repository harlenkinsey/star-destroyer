extends Node2D



func _ready():
	add_to_group('persist')
	$'CanvasLayer/filter'.set_modulate(Color(1,1,1,.85))



func _on_respawn_pressed():
	$'guiExit'.play()



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict



func _on_guiExit_finished():
	for i in $'CanvasLayer'.get_children():
		i.hide()
	var player = load('res://Player/Player.tscn').instance()
	get_tree().get_root().get_node('Main').add_child(player)
	player.set_position(Vector2(0,0))
	plVars.vars.energy = 0
	plVars.vars.shipHealth = 100
	plVars.vars.shipFuel = 100
	plVars.vars.alive = true
