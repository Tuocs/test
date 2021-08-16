extends KinematicBody2D

var velocity = Vector2()
var Health = 20
var speed = 100
var damage = 10

const GRAVITY = 50
const UP = Vector2.UP

const bouncy = true
const enemy = true

onready var target = get_node("../../PlayerScene/Player")

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
	var mypos = transform.origin.x
	var tarpos = target.transform.origin.x
	
	print (mypos, " ", tarpos)

	if tarpos > mypos:
		velocity.x = speed
		print ("right")
	if tarpos < mypos:
		velocity.x = -speed
		print ("left")
		
	velocity = move_and_slide(velocity, UP)
