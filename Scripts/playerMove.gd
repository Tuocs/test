extends KinematicBody2D


export var moveSpeed = 600
export var accMult = 60
export var jumpSpeed = 700
export var fallSpeed = 50

export var jumpTolerance = 8

const upDir = Vector2(0, -1)

var velocity = Vector2()


func _ready():
	$JumpCast1.cast_to.y = jumpTolerance
	$JumpCast2.cast_to.y = jumpTolerance


#bullets will call this on anything they hit that has it
func hit(amount):
	$Health.Dmg(amount)


func _process(delta):
	
	player_move(delta)


func player_move(delta):
	#player falls
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += fallSpeed
	
	
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
	
	
	#extend jump raycast in the direction of movement
	#$JumpCast1.cast_to.y = velocity.y * delta * 3
	#$JumpCast1.cast_to.y = clamp($JumpCast1.cast_to.y, 6, velocity.y * delta * 3)
	#$JumpCast2.cast_to.y = velocity.y * delta * 3
	#$JumpCast2.cast_to.y = clamp($JumpCast2.cast_to.y, 6, velocity.y * delta * 3)
	#&& !Input.is_action_pressed("ui_down")
	#player jumps
	if Input.is_action_just_pressed("ui_accept") \
	&& ($JumpCast1.is_colliding() || $JumpCast2.is_colliding()) \
	:
		move_and_collide(Vector2(0, jumpTolerance))
		$JumpTimer.start()
		
	if Input.is_action_just_released("ui_accept"):
		$JumpTimer.stop()
		
	if is_on_ceiling():
		$JumpTimer.stop()
	
	if !$JumpTimer.is_stopped():
		velocity.y = -jumpSpeed
	
	
	#player position update
	move_and_slide(velocity, upDir)
