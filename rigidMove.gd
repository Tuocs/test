extends RigidBody2D


export var movespeed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	
	add_force(Vector2(),velocity * delta * movespeed)
