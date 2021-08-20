extends Node2D

var turretTexArr = ['res://assets/towerDefense_tile249.png','res://assets/doubleBarrel.png','res://assets/threeBarrel.png']
var turretChance = 0
var state = 'idle'
var direction = 'left'


func init():
	var ran = RandomNumberGenerator.new()
	ran.randomize()
	
	turretChance = ran.randi_range(0,2)
	$'turret'.set_texture(load(turretTexArr[turretChance]))



func state_machine():
	var ran = RandomNumberGenerator.new()
	match state:
		'idle':
			if $'randMove'.is_stopped():
				ran.randomize()
				
				var dir = ran.randi_range(0,1)
				
				$'randMove'.set_wait_time(ran.randi_range(1, 3))
				$'randMove'.start()
				
				if dir == 0:
					direction = 'left'
				elif dir == 1:
					direction = 'right'
				
			elif !$'randMove'.is_stopped():
				if direction == 'left':
					self.rotation_degrees -= 1
					$'base'.rotation_degrees += 1
				elif direction == 'right':
					self.rotation_degrees += 1
					$'base'.rotation_degrees -= 1
		'detected':
			look_at(get_tree().get_nodes_in_group('Player')[0].get_position())
			self.rotation_degrees += 90
			$'base'.look_at(Vector2(get_position().x, get_position().y - 50))
			$'base'.rotation_degrees -= 90



func _process(delta):
	state_machine()



func _on_detector_body_entered(body):
	if body.name == 'Player':
		state = 'detected'



func _on_detector_body_exited(body):
	if body.name == 'Player':
		state = 'idle'
