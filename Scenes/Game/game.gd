extends Node2D

@onready var _score = $"GUI/MarginContainer/VBoxContainer/Score/Points"
@export var speed = 1
@export var isDead = false
@onready var regEnemTimer = $RegularEnemyTimer
@onready var skyEnemTimer = $SkyEnemyTimer

@onready var vars = get_node("/root/first")

@export var winScore = 150

var enemies = []

var skyenemies = []

var rng = RandomNumberGenerator.new()

var score = 0


func _ready():
	var bigship = load("res://Objects/Enemies/BigShip/bigship.tscn")
	enemies.append(bigship)
	var island = load("res://Objects/Enemies/Island/island.tscn")
	enemies.append(island)
	var airplane = load("res://Objects/Enemies/Airplane/airplane.tscn")
	skyenemies.append(airplane)

func _process(delta):
	
	score += speed * delta
	
	speed += delta*0.07
	
	_score.text = str(int(score)) + "m"
	
	if (vars.endless == false) and (score >= winScore):
		get_tree().change_scene_to_file("res://Scenes/Victory/victory.tscn")
	
	if isDead:
		speed = 0

func _on_regular_enemy_timer_timeout():
		if !isDead:
			var rand_enemy:int = randi() % enemies.size()
			var enemy = enemies[rand_enemy].instantiate()
			if randf() < 0.5:
				enemy.get_node("MainSprite").flip_h = true
			add_child(enemy)
			regEnemTimer.wait_time = rng.randf_range(3, 15)


func _on_sky_enemy_timer_timeout():
		if !isDead:
			var rand_enemy:int = randi() % skyenemies.size()
			var enemy = skyenemies[rand_enemy].instantiate()
			if randf() < 0.5:
				enemy.get_node("MainSprite").flip_h = true
			add_child(enemy)
			skyEnemTimer.wait_time = rng.randf_range(3, 10)
