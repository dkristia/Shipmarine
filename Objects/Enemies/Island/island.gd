extends "res://Objects/Enemies/BaseEnemy/enemy.gd"

var islandbottom = preload("res://Objects/Enemies/Island/islandbottom.tscn")

func _ready():
	position.x = 1100
	super._ready()
	var currenty = 148
	for n in 300:
		var bottom = islandbottom.instantiate()
		add_child(bottom)
		bottom.position.y = currenty
		currenty += 148


func _process(delta):
	super._process(delta)
