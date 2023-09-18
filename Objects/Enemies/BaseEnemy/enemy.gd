extends Area2D


@onready var speed = $"/root/Game".speed
@onready var isplayerdead = $"/root/Game".isDead
@onready var explosion = $"/root/Game/Ship/Explosion"
@onready var mainSprite = $MainSprite
var _explosion = preload("res://Sprites/Ship/explosion.png")
var gameOverscene = preload("res://Scenes/GameOver/game_over.tscn")


func _ready():
	position.x = 1920.0/2.0+500.0 + float(mainSprite.texture.get_width())/2.0 * float(mainSprite.scale.x)
	position.y = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = $"/root/Game".speed
	position.x -= delta*speed*100
	if position.x <= -1000:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("player_character"):
		$"/root/Game/AudioStreamPlayer".stop()
		$"/root/Game".isDead = true
		explosion.play()
		await get_tree().create_timer(3).timeout
		var gameOver = gameOverscene.instantiate()
		add_sibling(gameOver)
