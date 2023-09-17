extends Control


var credits = preload("res://Scenes/Credits/credits.tscn")
@onready var first_time = get_node("/root/first").first

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_pressed():
	if first_time:
		get_tree().change_scene_to_file("res://Scenes/Cutscene/cutscene.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_credits_pressed():
	var credits_open = credits.instantiate()
	add_sibling(credits_open)


func _on_exit_pressed():
	get_tree().quit()
