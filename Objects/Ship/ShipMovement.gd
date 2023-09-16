extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 15.0
var WATER_UPWARD_FORCE = -900.0
const WATER_SURFACE_HEIGHT = 0.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _background = $Camera2D/ColorRect
@onready var _depth_text = $"../CanvasLayer/MarginContainer/HBoxContainer/Depth"
@onready var _depth_meter = $"../CanvasLayer/MarginContainer/HBoxContainer/Depth/DepthMeter"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var inWater = false


func _physics_process(delta):
	
	if position.y <= 0:
		_depth_text.text = "Height"
	else:
		_depth_text.text = "Depth"
	_depth_meter.text = str(int(abs(position.y)/30)) + "m."
	
	if abs(position.y) >= 5000:
		_background.color.a = 0
	else:
		_background.color.a = (10000 - abs(position.y)*2) * 0.0001
		
	WATER_UPWARD_FORCE = position.y * -2 - 500
	if inWater:
		velocity.y += WATER_UPWARD_FORCE * delta
	else:
		if position.y >= 10000:
			velocity.y += gravity * delta * 0.1
		else:
			velocity.y += (gravity - position.y * 0.1) * delta

	if Input.get_action_strength("ui_accept") != 0:
		velocity.y += JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_accept"):
		_animated_sprite.play("startup")
		await _animated_sprite.animation_finished
		_animated_sprite.play("activated")
		
	if Input.is_action_just_released("ui_accept"):
		_animated_sprite.play("startup-reversed")
		await _animated_sprite.animation_finished
		_animated_sprite.play("default")
	
	if (-20 < position.y and position.y < 20) and (-10 < velocity.y and velocity.y < 10):
		velocity.y = 0

	move_and_slide()

func _on_water_area_2d_body_entered(body):
	if body.is_in_group("player_character"):
		inWater = true
		velocity.y -= velocity.y*0.6

func _on_water_area_2d_body_exited(body):
	if body.is_in_group("player_character"):
		inWater = false
