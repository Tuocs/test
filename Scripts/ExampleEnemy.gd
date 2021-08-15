extends KinematicBody2D

var Health = 20


func hit(dmg):
	Health-=dmg
	if Health <= 0:
		Die()

func Die():
	queue_free()


func _process(delta):
	pass
