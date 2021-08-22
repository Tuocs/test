extends KinematicBody2D


export var moveSpeed = 200
export var attackDistance = 200

var velocity = Vector2()

onready var player = get_node("../../PlayerScene/Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.distance_to(player.global_position) < attackDistance:
		var xDirToPlayer = global_position.direction_to(player.global_position).x
		
		if xDirToPlayer > 0:
			xDirToPlayer = 1
		else:
			xDirToPlayer = -1
		
		#move only when hopping in the animation
		if $AnimatedSprite.frame > 1:
			velocity.x += Globals.accMult * xDirToPlayer
		else: #decelerate
			velocity.x -= Globals.accMult * sign(velocity.x)
		
		#in case it oscillates around zero
		if abs(velocity.x) < Globals.accMult:
			velocity.x = 0
		
		velocity.x = clamp(abs(velocity.x), 0, moveSpeed) * sign(velocity.x)
	else: #just try to decelerate
		velocity.x -= Globals.accMult * sign(velocity.x)
		
		#in case it oscillates around zero
		if abs(velocity.x) < Globals.accMult:
			velocity.x = 0
	
	#fall off of ledges
	if !($FallCast1.is_colliding() || $FallCast2.is_colliding()):
		velocity.y += Globals.fallSpeed
	else:
		velocity.y = 0
	
	velocity.y = clamp(velocity.y, -Globals.maxYVel, Globals.maxYVel)
	
	move_and_slide(velocity, Vector2.UP)
