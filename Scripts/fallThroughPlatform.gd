extends StaticBody2D


export var length = 1

var sprites = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	if length > 1:
		for i in range(length - 1):
			var s = $Sprite.duplicate()
			s.position.x += 16 * (i + 1)
			add_child(s)
		
		$CollisionShape2D.shape.extents.x *= length #length is being shared across all instances, for some reason?
		$CollisionShape2D.position.x += 16 * (length/2)
		print($CollisionShape2D.shape.extents.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < get_node("../Player/JumpArea").global_position.y \
	|| Input.is_action_pressed("ui_down"):
		collision_layer = 0b0
		collision_mask = 0b0
	else:
		collision_layer = 0b11
		collision_mask = 0b11
