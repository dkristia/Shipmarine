extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
