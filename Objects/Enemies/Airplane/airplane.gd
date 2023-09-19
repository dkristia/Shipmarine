extends "res://Objects/Enemies/BaseEnemy/enemy.gd"


func _ready():
	super._ready()
	position.y = randf_range(-200, -1200)
	movespeed = 75


func _process(delta):
	super._process(delta)
		

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		self.mainSprite.set_texture(_explosion)
		area.find_child("MainSprite").set_texture(_explosion)
		area.remove_from_group("enemy")
		self.remove_from_group("enemy")
		delete_item(area, 1)
		delete_item(self, 1)
