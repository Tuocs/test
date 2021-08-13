extends KinematicBody2D


export var moveSpeed = 600
export var jumpSpeed = 700
export var fallSpeed = 50

const upDir = Vector2(0, -1)

var velocity = Vector2()


func _ready():
	pass


func _process(delta):
	
	#player falls
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += fallSpeed
	
	#player jumps
	if Input.is_action_just_pressed("ui_up") && $JumpArea.get_overlapping_bodies().size() > 0:
		move_and_collide(Vector2(0, 64))
		$JumpTimer.start()
	if Input.is_action_just_released("ui_up"):
		$JumpTimer.stop()
	
	if !$JumpTimer.is_stopped():
		velocity.y = -jumpSpeed
	
	#player goes left right
	if Input.is_action_pressed("ui_left"):
		velocity.x = -moveSpeed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = moveSpeed
	else:
		velocity.x = 0
	
	#player position update
	move_and_slide(velocity, upDir)
