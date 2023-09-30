extends Area2D


@onready var speed = $"/root/Game".speed
@onready var isplayerdead = $"/root/Game".isDead
@onready var isPaused = $"/root/Game".isPaused
@export var explosive = true
@onready var mainSprite = $MainSprite
var _explosion = preload("res://Sprites/Ship/explosion.png")
var _warning = preload("res://warning.png")

var movespeed = 20


func _ready():
	position.x = 2000 + float(mainSprite.texture.get_width())/2.0 * float(mainSprite.scale.x)
	position.y = 0.0
	var warningsprite = Sprite2D.new()
	warningsprite.name = "WarningSprite"
	warningsprite.set_texture(_warning)
	add_child(warningsprite)
	var visibleOnScreen = VisibleOnScreenNotifier2D.new()
	visibleOnScreen.name = "VisibilityNotifier"
	visibleOnScreen.rect = Rect2(-mainSprite.texture.get_width()/2, -mainSprite.texture.get_height()/2, mainSprite.texture.get_width(), mainSprite.texture.get_height())
	add_child(visibleOnScreen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	isplayerdead = $"/root/Game".isDead
	if !isplayerdead and !isPaused:
		if has_node("WarningSprite"):
			var warningsprite = get_node("WarningSprite")
			warningsprite.position.x = -position.x + 1300
			if get_node("VisibilityNotifier").is_on_screen():
				warningsprite.queue_free()
		speed = $"/root/Game".speed
		position.x -= delta*speed*100
		if position.x <= -1000 and !is_in_group("exploded") :
			queue_free()
		if $MainSprite.flip_h:
			position.x += delta*movespeed
		else:
			position.x -= delta*movespeed


func _on_body_entered(body):
	if body.is_in_group("player_character") and !is_in_group("exploded"):
		$"/root/Game"._kill_player()
		
func delete_item(item, when):
	if !isplayerdead:
		await get_tree().create_timer(when).timeout
		if item != null:
			item.queue_free()
	
func _on_area_entered(area):
	if area.explosive:
		area.find_child("MainSprite").set_texture(_explosion)
		area.add_to_group("exploded")
		delete_item(area, 1)
	if explosive:
		$MainSprite.set_texture(_explosion)
		add_to_group("exploded")
		delete_item(self, 1)
