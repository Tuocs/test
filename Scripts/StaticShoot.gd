extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		shoot()

func shoot():
	var Bullet = load ("res://Spawnables/Bullet.tscn")
	var b = Bullet.instance()
	add_child(b)
	#b.transform = transform
