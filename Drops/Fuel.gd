extends Node2D


func _ready():
	add_to_group('persist')



func _on_pickup_body_entered(body):
	if body.name == 'Player':
		$'pickupSound'.play()
		self.hide()



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict



func _on_Decay_timeout():
	remove_from_group('persist')
	queue_free()



func _on_pickupSound_finished():
	if plVars.vars.shipFuel <= 95:
			plVars.vars.shipFuel += 5
	elif plVars.vars.shipFuel > 95:
		plVars.vars.shipFuel = 100
	queue_free()
