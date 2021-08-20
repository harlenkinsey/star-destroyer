extends KinematicBody2D

var state = 'Pursuit'
var maxHealth = 50
var health = 50



func _ready():
	add_to_group('persist')



func _process(delta):
	state_machine()
	death()



func state_machine():
	match state:
		'Pursuit':
			if plVars.vars.alive == true:
				$'main'.set_emitting(true)
				var dir = (get_tree().get_nodes_in_group('Player')[0].get_position() - get_position()).normalized()
				var speed = plVars.vars.shipSpeed - (plVars.vars.shipSpeed * .2)
				move_and_slide(Vector2(dir.x * speed , dir.y * speed))
				look_at(get_tree().get_nodes_in_group('Player')[0].get_position())
				self.rotation_degrees -= 90
		
		'Detected':
			look_at(get_tree().get_nodes_in_group('Player')[0].get_position())
			self.rotation_degrees -= 90
			$'main'.set_emitting(false)



func fire():
	var bullet = load('res://Bullet/Bullet.tscn').instance()
	get_parent().add_child(bullet)
	
	bullet.get_node('energyBall').set_texture(load('res://assets/enemyBullet.png'))
	bullet.get_node('Area2D').set_collision_layer_bit(1, false)
	bullet.get_node('Area2D').set_collision_mask_bit(1, false)
	bullet.get_node('Area2D').set_collision_layer_bit(2, false)
	bullet.get_node('Area2D').set_collision_mask_bit(2, false)
	
	var dir = (($'followPoint'.get_global_position() - get_global_position()).normalized())
	var offset = dir * 50
	
	bullet.set_position(get_position() + offset)
	
	bullet.vel = dir * 200
	
	$'fire'.play()



func on_damage():
	health -= plVars.vars.bulletDamage



func death():
	if health <= 0:
		var ran = RandomNumberGenerator.new()
		
		for i in range(maxHealth/5):
			ran.randomize()
			var x = ran.randi_range(-25,25)
			ran.randomize()
			var y = ran.randi_range(-25,25)
			
			var newFuel = load('res://Drops/Fuel.tscn').instance()
			get_tree().get_root().get_node('Main').add_child(newFuel)
			newFuel.set_global_position(get_global_position() + Vector2(x,y))
		
		
		for i in range(maxHealth/5):
			ran.randomize()
			var x = ran.randi_range(-25,25)
			ran.randomize()
			var y = ran.randi_range(-25,25)
			
			var newEner = load('res://Drops/Energy.tscn').instance()
			get_tree().get_root().get_node('Main').add_child(newEner)
			newEner.set_global_position(get_global_position() + Vector2(x,y))
		
		remove_from_group('persist')
		queue_free()



func _on_Detector_body_entered(body):
	if body.name == 'Player':
		state = 'Detected'



func _on_Detector_body_exited(body):
	if body.name == 'Player':
		state = 'Pursuit'



func _on_Fire_timeout():
	if state == 'Detected':
		fire()



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
