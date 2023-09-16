extends Area2D


@onready var speed = $"..".speed
func _ready():
	position.x = 1500
	position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = $"..".speed
	position.x -= delta*speed*100


func _on_body_entered(body):
	if body.is_in_group("player_character"):
		get_tree().change_scene_to_file("res://Scenes/GameOver/game_over.tscn")
