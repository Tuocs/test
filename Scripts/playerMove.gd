extends KinematicBody2D


export var moveSpeed = 600
export var jumpSpeed = 700
export var hurtSpeed = 1000

export var jumpTolerance = 8

export var bounceMultiplier = 1.5

export(AudioStream) var jumpSound
export(AudioStream) var hurtSound

const upDir = Vector2(0, -1)

var velocity = Vector2()

var hurtable = true

var rand = RandomNumberGenerator.new()


func _ready():
	#set up jump assist
	$JumpCast1.cast_to.y = jumpTolerance
	$JumpCast2.cast_to.y = jumpTolerance
	$JumpCast3.cast_to.y = jumpTolerance


#bullets will call this on anything they hit that has it
func hit(amount):
	$Health.Dmg(amount)
	
	$SoundPlayer.stream = hurtSound
	$SoundPlayer.play()


func _process(delta):
	player_move(delta)
	
	display_movedir()
	
	hit_by_enemies()
	
	fall_through_plats()
	
	#player position update
	velocity = move_and_slide(velocity, upDir)


func fall_through_plats():
	if Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_accept"):
		collision_layer &= ~0b10
		collision_mask &= ~0b10
	else:
		collision_layer |= 0b10
		collision_mask |= 0b10


func hit_by_enemies():
	if hurtable:
		for body in $Hurtbox.get_overlapping_bodies():
			
			#if you hit an enemy, take damage and get flung away
			if "enemy" in body:
				hit(body.damage)
				
				#find the direction to launch the player
				var pos_diff = (global_position - body.global_position).normalized()
				
				#make them go farther in the x direction, and add x velocity if there is none
				if pos_diff.x == 0:
					pos_diff.x = 1
				
				velocity = pos_diff * hurtSpeed
				
				#start some invulnerability time after being hit, and take away control a little
				hurtable = false
				modulate.a = .5
				$HurtTimer.start()
				
				#knock the enemy away from the player
				if body.has_method("get_knocked"):
					body.get_knocked()
				
				return


#display which direction the player is holding
func display_movedir():
	#red dot
	var movedir = Vector2(-int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right")), \
	int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
	$MoveDir.rect_position = lerp($MoveDir.rect_position, movedir * 32 - Vector2(4,4), .2)
	
	#change sprite orientation
	if velocity.x > 0:
		$AnimatedSprite.flip_h = 0
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = 1
	
	#choose which anim to use
	if abs(velocity.x) > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.speed_scale = abs(velocity.x) / moveSpeed
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.speed_scale = 1


func player_move(delta):
	#check if the player is on the floor
	var on_floor = test_move(global_transform, Vector2(0,1))
	
	#player falls
	if on_floor:
		velocity.y = 0
	else:
		velocity.y += Globals.fallSpeed
	
	
	#player goes left right
	if Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		velocity.x -= Globals.accMult
	elif Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		velocity.x += Globals.accMult
	else: #decelerate when no button pressed
		velocity.x += -sign(velocity.x) * Globals.accMult
		if abs(velocity.x) < Globals.accMult:
			velocity.x = 0
	
	velocity.x = clamp(velocity.x, -moveSpeed, moveSpeed)
	
	
	#player jumps
	if Input.is_action_just_pressed("ui_accept") \
	&& ($JumpCast1.is_colliding() || $JumpCast2.is_colliding() || $JumpCast3.is_colliding()) \
	&& !Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2(0, jumpTolerance))
		$JumpTimer.start()
		
		#play the jump sound
		$SoundPlayer.stream = jumpSound
		$SoundPlayer.play()
	
	if Input.is_action_just_released("ui_accept"):
		$JumpTimer.stop()
	
	if is_on_ceiling():
		$JumpTimer.stop()
	
	if !$JumpTimer.is_stopped():
		velocity.y = -jumpSpeed
	
	velocity.y = clamp(velocity.y, -Globals.maxYVel, Globals.maxYVel)


func _on_Area2D_body_entered(body):
	#bounce the player on enemies and such when down-hit
	if "bouncy" in body && Input.is_action_pressed("ui_down"):
		velocity.y = -jumpSpeed * bounceMultiplier


func _on_HurtTimer_timeout():
	modulate.a = 1.0
	hurtable = true

