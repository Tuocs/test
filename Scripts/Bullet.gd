extends Area2D


export var speed = 0
export var dmg = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.has_method("hit"):
		body.hit(dmg)
	queue_free()
