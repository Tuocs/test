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

export var flying = false

func hit(dmg):
	Health -= dmg
	
	if Health <= 0:
		Die()


func Die():
	queue_free()


func _physics_process(delta):
	if flying:
		moveAir()
	else:
		moveGround()
	
	velocity = move_and_slide(velocity, UP)


func check_los():
	#use a raycast or area2d to check if can see target
	return true


func moveAir():
	var mypos = global_position
	var tarpos = target.global_position
	
	if tarpos.x > mypos.x+2 :
		velocity.x = speed
	if tarpos.x < mypos.x-2 :
		velocity.x = -speed
		
		
	if tarpos.y > mypos.y+2 :
		velocity.y = speed
	if tarpos.y < mypos.y-2 :
		velocity.y = -speed


func moveGround():
	#reset velocity
	velocity.x = 0
	
	
	#gravity and floor
	var on_floor = test_move(global_transform, Vector2(0,1))
	if on_floor:
		velocity.y = 0
	else:
		velocity.y += GRAVITY
	
	
	#ai stuff
	var mypos = global_position.x
	var tarpos = target.global_position.x
	
	if tarpos > mypos+2 :
		velocity.x = speed
	if tarpos < mypos-2 :
		velocity.x = -speed
