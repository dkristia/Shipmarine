extends ParallaxBackground

@onready var speed = $"/root/Game".speed
@onready var sky = $Clouds/Sky
# Called when the node enters the scene tree for the first time.
func _ready():
	sky.position.y = -sky.texture.get_height()*1.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = $"/root/Game".speed
	scroll_base_offset -= Vector2(100*speed, 0) * delta
