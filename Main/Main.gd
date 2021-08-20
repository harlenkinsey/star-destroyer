extends Node2D

func _ready():
	get_tree().set_auto_accept_quit(false)
	var saveF = File.new()
	if !saveF.file_exists('user://save.save'):
		var controls = load('res://UI/Controls/Controls.tscn').instance()
		var player = load('res://Player/Player.tscn').instance()
		var statBars = load('res://UI/statBars/statBars.tscn').instance()
		var pauseBars = load('res://UI/Pause/pause.tscn').instance()
		var gameOver = load('res://UI/Game_Over/gameOver.tscn').instance()
		add_child(gameOver)
		add_child(pauseBars)
		add_child(controls)
		add_child(statBars)
		add_child(player)
		for i in range(-10240,10240,1024):
				for j in range(-10240,10240,1024):
					if j == -10240 or i == -10240:
						var newBarrier = load('res://spaceBarrier/spaceBarrier.tscn').instance()
						add_child(newBarrier)
						newBarrier.set_position(Vector2(i,j))
					else:
						var newSpace = load('res://spaceBlock/spaceBlock.tscn').instance()
						add_child(newSpace)
						newSpace.set_position(Vector2(i,j))
						newSpace.name = 'spaceBlock' + str(save.numOfSB)
						save.numOfSB += 1
						newSpace.init()
		$'loadTimer1'.start()
	else:
		save._load()



func _on_saveTimer_timeout():
	save.save()


func _on_loadTimer1_timeout():
	for i in range(10240,31744,1024):
				for j in range(-10240,10240,1024):
					if j == -10240 or i == 30720:
						var newBarrier = load('res://spaceBarrier/spaceBarrier.tscn').instance()
						add_child(newBarrier)
						newBarrier.set_position(Vector2(i,j))
					else:
						var newSpace = load('res://spaceBlock/spaceBlock.tscn').instance()
						add_child(newSpace)
						newSpace.set_position(Vector2(i,j))
						newSpace.name = 'spaceBlock' + str(save.numOfSB)
						save.numOfSB += 1
						newSpace.init()
	$'loadTimer2'.start()


func _on_loadTimer2_timeout():
	for i in range(-10240,10240,1024):
				for j in range(10240,31744,1024):
					if i == -10240 or j == 30720:
						var newBarrier = load('res://spaceBarrier/spaceBarrier.tscn').instance()
						add_child(newBarrier)
						newBarrier.set_position(Vector2(i,j))
					else:
						var newSpace = load('res://spaceBlock/spaceBlock.tscn').instance()
						add_child(newSpace)
						newSpace.set_position(Vector2(i,j))
						newSpace.name = 'spaceBlock' + str(save.numOfSB)
						save.numOfSB += 1
						newSpace.init()
	$'loadTimer3'.start()


func _on_loadTimer3_timeout():
	for i in range(10240,31744,1024):
				for j in range(10240,31744,1024):
					if i == 30720 or j == 30720:
						var newBarrier = load('res://spaceBarrier/spaceBarrier.tscn').instance()
						add_child(newBarrier)
						newBarrier.set_position(Vector2(i,j))
					else:
						var newSpace = load('res://spaceBlock/spaceBlock.tscn').instance()
						add_child(newSpace)
						newSpace.set_position(Vector2(i,j))
						newSpace.name = 'spaceBlock' + str(save.numOfSB)
						save.numOfSB += 1
						newSpace.init()
	save.save()



func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save.save()
		get_tree().quit()



var loaded = false

func gameOver():
	pass
