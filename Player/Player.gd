extends Node2D



func _ready():
	add_to_group('Player')
	add_to_group('persist')
	if plVars.vars.tutorialDone == true:
		get_parent().gameOver()


func fire():
	var bullet = load('res://Bullet/Bullet.tscn').instance()
	get_parent().add_child(bullet)
	
	var dir = (($'followPoint'.get_global_position() - get_global_position()).normalized())
	var offset = dir * 50
	
	bullet.set_position(get_position() + offset)
	
	bullet.vel = dir * plVars.vars.bulletSpeed



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		for i in $'ShipUpgrades/CanvasLayer'.get_children():
			i.show()



func _on_Player_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		$'guiClick'.play()
		get_parent().get_node('Controls').set_process(false)
		for i in $'ShipUpgrades/CanvasLayer'.get_children():
			if i.get_index() < 26:
				i.show()



func _process(delta):
	if plVars.vars.shipHealth < 0 or plVars.vars.shipFuel < 0:
		if plVars.vars.alive == true:
			for i in get_parent().get_node('gameOver/CanvasLayer').get_children():
				i.show()
			plVars.vars.alive = false
			queue_free()



func on_damage():
	plVars.vars.shipHealth -= 10



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y,
		'rotation_degrees': self.rotation_degrees
	}
	return dict


func _on_tutTimer_timeout():
	if plVars.vars.tutorialDone == false:
		var dialogBox = load('res://UI/Dialog_Box/DialogBox.tscn').instance()
		get_parent().add_child(dialogBox)
		dialogBox.set_msg(['Hello fellow star destroyer, my name is Alexa!', 'I am here to assist you in becoming the best star destroyer...','...this galaxy has ever seen.', 'Your goal is to blow up as many stars as possible by shooting them,','then collect the energy and matter they leave behind.', 'Tap on your ship to access ship upgrades and to repair.', 'Good luck!'])
		dialogBox.set_name('Alexa')
		plVars.vars.tutorialDone = true
