extends Node2D



# shoot if press esc
func _process(delta):
	if Input.is_action_just_pressed("ui_page_up"):
		shoot()

#spawn bullet at location
func shoot():
	var Bullet = load ("res://Scenes/Spawnables/Bullet.tscn")
	var b = Bullet.instance()
	add_child(b)
	#b.transform = transform
