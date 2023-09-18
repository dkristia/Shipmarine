extends "res://Objects/Enemies/BaseEnemy/enemy.gd"


func _ready():
	super._ready()
	position.y = randf_range(-100, -1100)


func _process(delta):
	super._process(delta)
	if $MainSprite.flip_h:
		position.x += speed*delta*75
	else:
		position.x -= speed*delta*75
		

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		mainSprite.set_texture(_explosion)
		area.find_child("MainSprite").set_texture(_explosion)
		await(1)
		area.queue_free()
		queue_free()
