extends TextureRect

func _gui_input(event):
	
	if event is InputEventScreenTouch and event.pressed:
		get_parent().get_parent().leftPressed = true
	elif event is InputEventScreenTouch and not event.pressed:
		get_parent().get_parent().leftPressed = false
