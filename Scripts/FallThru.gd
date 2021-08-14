extends TileMap


export var length = 1

var sprites = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		collision_layer = 0b0
		collision_mask = 0b0
	else:
		collision_layer = 0b11
		collision_mask = 0b11
