extends KinematicBody2D


export var moveSpeed = 600
export var accMult = 60
export var jumpSpeed = 700
export var fallSpeed = 50
export var maxYVel = 1000

export var jumpTolerance = 8

export var bounceMultiplier = 1.5

const upDir = Vector2(0, -1)

var velocity = Vector2()


func _ready():
	#set up jump assist
	$JumpCast1.cast_to.y = jumpTolerance
	$JumpCast2.cast_to.y = jumpTolerance


#bullets will call this on anything they hit that has it
func hit(amount):
	$Health.Dmg(amount)


func _process(delta):
	
	player_move(delta)
	
	display_movedir()


#display which direction the player is holding
func display_movedir():
	var movedir = Vector2(-int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right")), \
	int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
	$MoveDir.rect_position = lerp($MoveDir.rect_position, movedir * 32 - Vector2(4,4), .2)


func player_move(delta):
	#check if the player is on the floor
	var on_floor = test_move(global_transform, Vector2(0,1))
	
	#player falls
	if on_floor:
		velocity.y = 0
	else:
		velocity.y += fallSpeed
	
	
	#player goes left right
	if Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		velocity.x -= accMult
	elif Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		velocity.x += accMult
	else: #decelerate when no button pressed
		velocity.x += -sign(velocity.x) * accMult
		if abs(velocity.x) < accMult:
			velocity.x = 0
	
	velocity.x = clamp(velocity.x, -moveSpeed, moveSpeed)
	
	
	#player jumps
	if Input.is_action_just_pressed("ui_accept") \
	&& ($JumpCast1.is_colliding() || $JumpCast2.is_colliding()) \
	&& !Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2(0, jumpTolerance))
		$JumpTimer.start()
		
	if Input.is_action_just_released("ui_accept"):
		$JumpTimer.stop()
		
	if is_on_ceiling():
		$JumpTimer.stop()
	
	if !$JumpTimer.is_stopped():
		velocity.y = -jumpSpeed
	
	velocity.y = clamp(velocity.y, -maxYVel, maxYVel)
	
	
	#player position update
	move_and_slide(velocity, upDir)


func _on_Area2D_body_entered(body):
	#bounce the player on enemies and such when down-hit
	if "bouncy" in body && Input.is_action_pressed("ui_down"):
		velocity.y = -jumpSpeed * bounceMultiplier
