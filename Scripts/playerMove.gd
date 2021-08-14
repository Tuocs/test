extends KinematicBody2D


export var moveSpeed = 600
export var accMult = 60
export var jumpSpeed = 700
export var fallSpeed = 50

const upDir = Vector2(0, -1)

var velocity = Vector2()


func _ready():
	pass


#bullets will call this on anything they hit that has is
func hit(ammount):
	$Health.Dmg(ammount)


func _process(delta):
	
	player_move()


func player_move():
	#player falls
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += fallSpeed
	
	#player jumps
	if Input.is_action_just_pressed("ui_accept") && $JumpArea.get_overlapping_bodies().size() > 0:
		move_and_collide(Vector2(0, 64))
		$JumpTimer.start()
		
	if Input.is_action_just_released("ui_accept"):
		$JumpTimer.stop()
		
	if is_on_ceiling():
		$JumpTimer.stop()
	
	if !$JumpTimer.is_stopped():
		velocity.y = -jumpSpeed
	
	#player goes left right
	if Input.is_action_pressed("ui_left"):
		velocity.x -= accMult
	elif Input.is_action_pressed("ui_right"):
		velocity.x += accMult
	else: #decelerate when no button pressed
		velocity.x += -sign(velocity.x) * accMult
		if abs(velocity.x) < accMult:
			velocity.x = 0
	
	velocity.x = clamp(velocity.x, -moveSpeed, moveSpeed)
	
	
	#player position update
	move_and_slide(velocity, upDir)
