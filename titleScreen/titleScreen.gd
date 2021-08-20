extends Node2D

var curMove = 'left'



func _ready():
	if get_tree().has_group('space'):
			pass
	else:
		for i in range(-10240,10240,1024):
			for j in range(-10240,10240,1024):
				var newSpace = load('res://spaceBlock/spaceBlock.tscn').instance()
				add_child(newSpace)
				newSpace.set_position(Vector2(i,j))
				newSpace.init()



func cameraMove():
	match curMove:
		'left':
			$'cam'.position.x -= .3
			$'cam'.position.y -= .3
		'right':
			$'cam'.position.x += .3
			$'cam'.position.y += .3



func _process(delta):
	if $'cam'.position.x < -9000:
		curMove = 'right'
	elif $'cam'.position.x > 9000:
		curMove = 'left'
	cameraMove()



func _on_exitBtn_gui_input(event):
	if event is InputEventScreenTouch:
		$'guiExit'.play()
func _on_playBtn_gui_input(event):
	if event is InputEventScreenTouch:
		$'guiClick'.play()
		get_tree().change_scene("res://Main/Main.tscn")



func _on_guiExit_finished():
	get_tree().quit()
