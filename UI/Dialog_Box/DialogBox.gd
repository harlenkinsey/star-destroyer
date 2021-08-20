extends Node2D

var msgAr = []
var curMsg = 0

var nameDict = {
	'Alexa': 'res://assets/alexaDialogName.png',
	'Pilot': 'res://assets/pilotDialogName.png'
}



func _ready():
	$'CanvasLayer/arrowFloat'.play("arrow_float")
	$'msgNot'.play()



func set_msg(msgArr):
	msgAr = msgArr
	$'CanvasLayer/Dialog'.set_text(msgAr[curMsg])



func next_msg():
	curMsg += 1
	
	if curMsg + 1 > msgAr.size():
		$'guiExitTimer'.start()
	else:
		$'CanvasLayer/Dialog'.set_text(msgAr[curMsg])



func set_name(Name):
	$'CanvasLayer/Name'.set_texture(load(nameDict[Name]))



func _on_nextArrow_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		next_msg()
		if curMsg + 1 > msgAr.size():
			$"guiExit".play()
		else:
			$'guiClick'.play()


func _on_guiExitTimer_timeout():
	queue_free()
