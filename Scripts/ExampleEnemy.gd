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
	velocity.x = 0
	
	var mypos = global_position.x
	var tarpos = target.global_position.x
	
	if tarpos > mypos+2 :
		velocity.x = speed
	if tarpos < mypos-2 :
		velocity.x = -speed
		
	velocity = move_and_slide(velocity, UP)
