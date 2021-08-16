extends KinematicBody2D

var velocity = Vector2()
var Health = 20
var speed = 100
var damage = 10

const GRAVITY = 50
const UP = Vector2.UP

const bouncy = true
const enemy = true

func hit(dmg):
	Health -= dmg
	
	if Health <= 0:
		Die()


func Die():
	queue_free()


func _physics_process(delta):
	move()


func move():
	velocity.y += GRAVITY
	velocity.x = -speed
	
	velocity = move_and_slide(velocity, UP)
