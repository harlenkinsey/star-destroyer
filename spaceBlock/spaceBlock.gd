extends Node2D


func _ready():
	add_to_group('space')
	add_to_group('persist')



func init():
	var Ran = RandomNumberGenerator.new()
	Ran.randomize()
	var chance = Ran.randi_range(1, 100)
	
	if chance > 30 and get_position() != Vector2(0,0):
		var star = load("res://Star/Star.tscn").instance()
		add_child(star)
		star.set_position(Vector2(512,512))
		star.init()



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict
