extends "res://Objects/Enemies/BaseEnemy/enemy.gd"


func _ready():
	super._ready()
	position.y = randf_range(-100, -1100)
	movespeed = 75


func _process(delta):
	super._process(delta)
		

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		mainSprite.set_texture(_explosion)
		area.find_child("MainSprite").set_texture(_explosion)
		area.remove_from_group("enemy")
		self.remove_from_group("enemy")
		await get_tree().create_timer(1).timeout
		area.queue_free()
		queue_free()
