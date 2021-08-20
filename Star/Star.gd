extends Node2D

var stage = 1
var stageM = 1
var initStage = 1
var maxHealth = 50
var health = 50
var stageColors = ["",Color( 1, 1, 1, 1 ),Color( 1, 1, 0, 1 ),Color( 0.12, 0.56, 1, 1 ),Color( 0.8, 0.36, 0.36, 1 ),Color( 1, 0.27, 0, 1 )]
var initScale = get_scale()
var turret = 'res://Turret/Turret.tscn'
var enemiesSpawned = false
var scaleX = 1
var scaleY = 1



func _ready():
	add_to_group('persist')



func init():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var sizeChance = rand.randf_range(0,3)
	var stageChance = rand.randi_range(1,5)
	
	set_scale(get_scale() * Vector2(sizeChance, sizeChance))
	scaleX = get_scale().x
	scaleY = get_scale().y
	$"Light2D".texture_scale = $"Light2D".texture_scale * (sizeChance * .5)
	match stageChance:
		1:
			stageM = 5
			initStage = 1
		2:
			stageM = 4
			stage = 2
			initStage = 2
		3:
			stageM = 3
			stage = 3
			initStage = 3
		4:
			stageM = 2
			stage = 4
			initStage = 4
		5:
			stageM = 1
			stage = 5
			initStage = 5
	
	maxHealth = maxHealth * sizeChance * stageM
	health = maxHealth



func on_damage():
	health -= plVars.vars.bulletDamage
	scaleX = scaleX + (scaleX * .01)
	scaleY = scaleY + (scaleY * .01)
	
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var enemyChance = rand.randi_range(0, 3)
	var enemyPos = [Vector2(-500,0), Vector2(0,-500), Vector2(500,0), Vector2(0,500)]
	
	if enemiesSpawned == false:
		for i in range(enemyChance):
			var en = load('res://Enemy/Enemy.tscn').instance()
			get_parent().get_parent().add_child(en)
			en.set_position(get_global_position() + enemyPos[i])
		enemiesSpawned = true
		
		if enemyChance > 0:
			if !get_parent().get_parent().has_node('DialogBox'):
				var msgs = ['You better not!', 'Back off the star!', 'ITS ENERGY IS OURS!!!', 'We warned you.', '*Indistinct alien chatter*', 'do NOT!']
				var dialogBox = load('res://UI/Dialog_Box/DialogBox.tscn').instance()
				var random = RandomNumberGenerator.new()
				random.randomize()
				get_parent().get_parent().add_child(dialogBox)
				dialogBox.set_msg([msgs[random.randi_range(0, msgs.size() - 1)]])
				dialogBox.set_name('Pilot')
	
	
	if health < maxHealth * .8 and health > maxHealth * .6 and stage < 2:
		stage += 1
	elif health < maxHealth * .6 and health > maxHealth * .4 and stage < 3:
		stage += 1 
	elif health < maxHealth * .4 and health > maxHealth * .2 and stage < 4:
		stage += 1
	elif health < maxHealth * .2 and health > maxHealth * .1 and stage < 5:
		stage += 1
	elif health <= 0:
		var ran = RandomNumberGenerator.new()
		
		for i in range(maxHealth/5):
			ran.randomize()
			var x = ran.randi_range(-100,100)
			ran.randomize()
			var y = ran.randi_range(-100,100)
			
			var newFuel = load('res://Drops/Fuel.tscn').instance()
			get_tree().get_root().get_node('Main').add_child(newFuel)
			newFuel.set_global_position(get_global_position() + Vector2(x,y))
			
			
		for i in range(maxHealth/5):
			ran.randomize()
			var xx = ran.randi_range(-100,100)
			ran.randomize()
			var yy = ran.randi_range(-100,100)
			
			var newEner = load('res://Drops/Energy.tscn').instance()
			get_tree().get_root().get_node('Main').add_child(newEner)
			newEner.set_global_position(get_global_position() + Vector2(xx,yy))
			
			remove_from_group('persist')
			queue_free()



func _process(delta):
	set_scale(Vector2(scaleX, scaleY))
	set_modulate(stageColors[stage])
	get_node("Light2D").set_color(stageColors[stage])
	
	
	if $'StaticBody2D'.get_slide_count() > 0:
		var collision = $'StaticBody2D'.get_slide_collision(0)
		
		if collision.collider.name == 'Player':
			plVars.vars.shipHealth -= .1



func _physics_process(delta):
	$'StaticBody2D'.move_and_slide(Vector2(0,0))



func save():
	var dict = {
		'filename': get_filename(),
		'parent': get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y,
		'stage': stage,
		'stageM': stageM,
		'maxHealth': maxHealth,
		'health': health,
		'enemiesSpawned': enemiesSpawned,
		'scaleX': get_scale().x,
		'scaleY': get_scale().y
	}
	return dict
