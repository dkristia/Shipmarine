extends Node

@onready var _fps = $MarginContainer/VBoxContainer/FPS

var frames = 0

var seconds = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if seconds <= 1:
		frames += 1
		seconds += delta
		_fps.text = str(int(frames/seconds))
	else:
		frames = 0
		seconds = 0
