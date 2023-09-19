extends Control


var credits = preload("res://Scenes/Credits/credits.tscn")
@onready var vars = get_node("/root/first")

@onready var endlessLabel = $CanvasLayer/Settings/EndlessLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	endlessLabel.text = str(vars.endless)
	pass



func _on_play_pressed():
	if vars.first:
		get_tree().change_scene_to_file("res://Scenes/Cutscene/cutscene.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_credits_pressed():
	var credits_open = credits.instantiate()
	add_sibling(credits_open)


func _on_exit_pressed():
	get_tree().quit()


func _on_endless_pressed():
	vars.endless = !vars.endless
