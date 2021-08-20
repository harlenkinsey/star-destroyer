extends KinematicBody2D

var vel = Vector2(0,0)

func _on_Area2D_body_entered(body):
	if body.get_parent().has_method('on_damage'):
		body.get_parent().on_damage()
	elif body.has_method('on_damage'):
		body.on_damage()
	self.hide()
	$'bulletDie'.play()



func _on_decayTimer_timeout():
	self.hide()
	$'bulletDie'.play()



func _process(delta):
	move_and_slide(vel)



func _on_bulletDie_finished():
	queue_free()
