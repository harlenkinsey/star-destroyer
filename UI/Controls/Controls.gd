extends Node2D

var upPressed = false
var leftPressed = false
var rightPressed = false


func _ready():
	
	add_to_group('persist')
	$'reloadTime'.set_wait_time(plVars.vars.reloadTime)
	$'CanvasLayer/Fire'.set_max(plVars.vars.maxAmmo)


func Rotate(dir, switch):
	
	var player = get_tree().get_nodes_in_group('Player')[0]
	var rot = player.get_rotation_degrees()
	
	if dir == 'left' and switch:
		
		player.set_rotation_degrees(rot - plVars.vars.rotationSpeed)
		player.get_node('leftBooster').set_emitting(true)
		plVars.vars.shipFuel -= plVars.vars.fuelConsumption
		
		if !$'left'.is_playing():
			$'left'.play()
			
	elif dir == 'left' and not switch:
		
		player.get_node('leftBooster').set_emitting(false)
		
		if $'left'.is_playing():
			$'left'.stop()
			
	elif dir == 'right' and switch:
		
		player.set_rotation_degrees(rot + plVars.vars.rotationSpeed)
		player.get_node('rightBooster').set_emitting(true)
		plVars.vars.shipFuel -= plVars.vars.fuelConsumption
		
		if !$'right'.is_playing():
			$'right'.play()
	
	elif dir == 'right' and not switch:
		
		player.get_node('rightBooster').set_emitting(false)
		
		if $'right'.is_playing():
			$'right'.stop()


func forward(switch):
	
	var player = get_tree().get_nodes_in_group('Player')[0]
	var direction = (player.get_node('followPoint').get_global_position() - player.get_position()).normalized()
	var speed = plVars.vars.shipSpeed
	
	if switch:
		
		player.move_and_slide(Vector2(speed, speed) * direction)
		player.get_node('mainBooster').set_emitting(true)
		plVars.vars.shipFuel -= plVars.vars.fuelConsumption
		
		if !$'mainEngine'.is_playing():
			$'mainEngine'.play()
	
	else:
		
		player.get_node('mainBooster').set_emitting(false)
		
		if $'mainEngine'.is_playing():
			$'mainEngine'.stop()


func _process(delta):
	
	if plVars.vars.alive == true:
		
		var player = get_tree().get_nodes_in_group('Player')[0]
		
		if leftPressed:
			Rotate('left', true)
		else:
			Rotate('left', false)
		
		if rightPressed:
			Rotate('right', true)
		else:
			Rotate('right', false)
		
		if upPressed:
			forward(true)
		else:
			forward(false)
		
		$'CanvasLayer/Fire'.set_value(plVars.vars.ammo)



func _on_Fire_gui_input(event):
	
	if event is InputEventScreenTouch and event.is_pressed() and plVars.vars.ammo > 0 and plVars.vars.alive == true:
		$'reloadTime'.set_wait_time(plVars.vars.reloadTime)
		$'reloadTime'.start()
		
		var player = get_tree().get_nodes_in_group('Player')[0]
		plVars.vars.ammo -= 10
		player.fire()
		$'AudioStreamPlayer'.play()


func _on_reloadTime_timeout():
	
	if plVars.vars.ammo == 100:
		$'reloadTime'.stop()
	else:
		plVars.vars.ammo += 10


func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict
