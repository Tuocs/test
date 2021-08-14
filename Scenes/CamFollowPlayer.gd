extends Camera2D


export var followspeed = .1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = lerp(position.x, get_node("../Player").position.x, followspeed)
	position.y = lerp(position.y, get_node("../Player").position.y, followspeed)
