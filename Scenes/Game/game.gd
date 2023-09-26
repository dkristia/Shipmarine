extends Node2D

@onready var _score = $"GUI/MarginContainer/VBoxContainer/Score/Points"
@export var speed = 1
@export var isDead = false
@export var isPaused = false
@onready var regEnemTimer = $RegularEnemyTimer
@onready var skyEnemTimer = $SkyEnemyTimer

@onready var _pauseScreen = preload("res://Scenes/Game/Paused/paused.tscn")
var pauseScreen

@onready var vars = get_node("/root/first")

@export var winScore = 250

var enemies = []

var skyenemies = []

var timers = []

var score = 0

var gamespeed = 1

var countdown_multiplier = 2


func _ready():
	
	var bigship = load("res://Objects/Enemies/BigShip/bigship.tscn")
	enemies.append(bigship)
	var island = load("res://Objects/Enemies/Island/island.tscn")
	enemies.append(island)
	var airplane = load("res://Objects/Enemies/Airplane/airplane.tscn")
	skyenemies.append(airplane)
	
	timers.append(regEnemTimer)
	timers.append(skyEnemTimer)
	pauseScreen = _pauseScreen.instantiate()
	pauseScreen.get_node("CanvasLayer").visible = false
	add_child(pauseScreen)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if isPaused:
			isPaused = false
			pauseScreen.get_node("CanvasLayer").visible = false
		else:
			isPaused = true
			pauseScreen.get_node("CanvasLayer").visible = true
		
	if isDead or isPaused:
		speed = 0
		for timer in timers:   
			timer.paused = true
	else:
		for timer in timers:
			timer.paused = false
			
		score += speed * delta
	
		gamespeed += delta*0.07
		
		_score.text = str(int(score)) + "m"
		
		if(Input.get_action_strength("boost")!=0 and gamespeed+5>speed and vars.boostEnabled):
			speed +=0.3
		elif(Input.get_action_strength("boost")==0 and gamespeed<speed):
			speed -= 0.1
	
		if (vars.endless == false) and (score >= winScore):
			get_tree().change_scene_to_file("res://Scenes/Victory/victory.tscn")
	

func _on_regular_enemy_timer_timeout():
	_spawn_enemy(enemies, regEnemTimer, 10, 20)


func _on_sky_enemy_timer_timeout():
	_spawn_enemy(skyenemies, skyEnemTimer, 5, 10)


func _spawn_enemy(enemylist: Array, timer: Timer, r1: int, r2: int):
	var rng = RandomNumberGenerator.new()
	var rand_enemy:int = randi() % enemylist.size()
	var enemy = enemylist[rand_enemy].instantiate()
	if randf() < 0.5:
		enemy.get_node("MainSprite").flip_h = true
	add_child(enemy)
	var waitTime = rng.randf_range(r1, r2)
	timer.wait_time = r1/1.5 if waitTime/speed <= r1/1.5 else waitTime/speed
	
	
static func _kill_player():
	$"/root/Game/AudioStreamPlayer".stop()
	$"/root/Game".isDead = true
	$"/root/Game/Ship/Explosion".play()
	var timer = Timer.new()
	$"/root/Game".add_child(timer)
	timer.start(3)
	await timer.timeout
	$"/root/Game".add_child(preload("res://Scenes/GameOver/game_over.tscn").instantiate())
