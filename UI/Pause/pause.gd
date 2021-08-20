extends Node2D

func _ready():
	add_to_group('persist')
	$'CanvasLayer/filter'.set_modulate(Color(1,1,1,.85))


func _on_pauseBars_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		$'guiClick'.play()
		$'CanvasLayer2/pauseBars'.mouse_filter = Control.MOUSE_FILTER_IGNORE
		for i in $'CanvasLayer'.get_children():
			i.show()
		get_parent().get_node('Controls').upPressed = false
		get_tree().paused = true


func _on_resume_pressed():
	get_tree().paused = false
	for i in $'CanvasLayer'.get_children():
			i.hide()
	$'guiExit'.play()


func _on_saveexit_pressed():
	if get_parent().has_node('DialogBox'):
		get_parent().get_node('DialogBox').queue_free()
	save.save()
	get_tree().quit()


func _on_save_pressed():
	$'guiClick'.play()
	save.save()
	if get_parent().has_node('DialogBox'):
		get_parent().get_node('DialogBox').queue_free()
	var dialogBox = load('res://UI/Dialog_Box/DialogBox.tscn').instance()
	get_parent().add_child(dialogBox)
	dialogBox.set_msg(['Game saved!'])
	dialogBox.set_name('Alexa')


func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict


func _on_no_pressed():
	$'guiExit'.play()
	for i in $'CanvasLayer3'.get_children():
		i.hide()


func _on_xR_pressed():
	$'guiExit'.play()
	for i in $'CanvasLayer3'.get_children():
		i.hide()


func _on_yes_pressed():
	$'guiExit'.play()
	var dir = Directory.new()
	dir.remove("user://save.save")
	get_tree().paused = false
	plVars.vars = plVars['initVars']
	upgrades.vars = upgrades['initVars']
	upgrades.costs = upgrades['initCosts']
	plVars.vars.tutorialDone = false
	get_tree().change_scene("res://titleScreen/titleScreen.tscn")


func _on_reset_pressed():
	$'guiClick'.play()
	for i in $'CanvasLayer3'.get_children():
		i.show()


func _on_back_hide():
	$'CanvasLayer2/pauseBars'.mouse_filter = Control.MOUSE_FILTER_STOP
