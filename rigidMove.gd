extends KinematicBody2D


export var movespeed = 100

const upDir = Vector2(0, -1)


func _ready():
	pass


func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	
	
	
	move_and_slide(velocity * delta * movespeed, upDir)
