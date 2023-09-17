extends Control



func _ready():
	get_node("/root/first").first = false
	
@onready var canvaslayer = $CanvasLayer
@onready var working = $working
@onready var leaving = $leaving
var cutscene = 1

func _on_button_pressed():
	if cutscene == 12:
		get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")
	else:
		$CanvasLayer.get_node("Cutscene" + str(cutscene)).visible = false
		cutscene += 1
		$CanvasLayer.get_node("Cutscene" + str(cutscene)).visible = true
		if cutscene == 6 or cutscene == 7:
			if working.playing:
				working.stop()
			working.play()
		if cutscene == 12:
			leaving.play()
