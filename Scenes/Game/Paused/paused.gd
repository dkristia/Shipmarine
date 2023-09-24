extends Control

func _on_play_pressed():
	$"/root/Game".isPaused = false
	$"CanvasLayer".visible = false

func _on_exit_pressed():
	$"/root/Game"._kill_player()
	$"CanvasLayer".visible = false
