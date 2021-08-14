extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < get_node("../Player/JumpArea").global_position.y \
	|| Input.is_action_pressed("ui_down"):
		collision_layer = 0b0
		collision_mask = 0b0
	else:
		collision_layer = 0b11
		collision_mask = 0b11
