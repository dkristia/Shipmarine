extends Node2D

@onready var _score = $"CanvasLayer/MarginContainer/VBoxContainer/Score/Points"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var speed = 1
var score = 0


func _process(delta):
	
	score += delta
	
	speed += speed*delta*0.1
	
	_score.text = str(int(score))
