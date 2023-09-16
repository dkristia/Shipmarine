extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 50.0
const WATER_UPWARD_FORCE = -980.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var inWater = false

func _physics_process(delta):
	if inWater:
		velocity.y += WATER_UPWARD_FORCE * delta
	else:
		velocity.y += gravity * delta

	if Input.get_action_strength("ui_accept") != 0:
		velocity.y += JUMP_VELOCITY

	move_and_slide()

func _on_water_area_2d_body_entered(body):
	inWater = true
	velocity.y -= velocity.y*0.5

func _on_water_area_2d_body_exited(body):
	inWater = false
