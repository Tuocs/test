extends KinematicBody2D


export var moveSpeed = 200
export var attackDistance = 200
export var damage = 10
export var health = 20

var velocity = Vector2()

onready var player = get_node("../../PlayerScene/Player")

const enemy = true
const bouncy = true


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
		
		#stop it jiggling under the player
		if abs(player.global_position.x - global_position.x) < 15:
			velocity.x = 0
		
		velocity.x = clamp(abs(velocity.x), 0, moveSpeed) * sign(velocity.x)
		
	else: #just try to decelerate
		velocity.x -= Globals.accMult * sign(velocity.x)
		
		#in case it oscillates around zero
		if abs(velocity.x) < Globals.accMult:
			velocity.x = 0
	
	#check if the maggot is on the floor
	var on_floor = test_move(global_transform, Vector2(0,1))
	
	#maggot falls
	if on_floor:
		velocity.y = 0
	else:
		velocity.y += Globals.fallSpeed
	
	velocity.y = clamp(velocity.y, -Globals.maxYVel, Globals.maxYVel)
	
	move_and_slide(velocity, Vector2.UP)


#take damage
func hit(dmg):
	health -= dmg
	
	if health <= 0:
		die()


func die():
	queue_free()
