extends TileMap


export var length = 1

var original_collision = collision_mask

var sprites = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_accept"):
		collision_layer = 0b0
		collision_mask = 0b0
	else:
		collision_layer = original_collision
		collision_mask = original_collision
