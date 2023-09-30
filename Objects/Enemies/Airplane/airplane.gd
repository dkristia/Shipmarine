extends "res://Objects/Enemies/BaseEnemy/enemy.gd"


func _ready():
	super._ready()
	position.y = randf_range(-200, -1200)
	movespeed = 200


func _process(delta):
	super._process(delta)
		
