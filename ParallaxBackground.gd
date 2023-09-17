extends ParallaxBackground

@onready var speed = $"/root/Game".speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = $"/root/Game".speed
	scroll_base_offset -= Vector2(100*speed, 0) * delta
