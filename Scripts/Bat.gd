extends KinematicBody2D


export var health = 30
export var damage = 10
export var moveSpeed = 300
export var attackDistance = 200
export var jiggle = 200
export var knockSpeed = 500

var velocity = Vector2()
var target = Vector2()

var getting_knocked = false

onready var player = get_node("../../../PlayerScene/Player")
var date_time = OS.get_datetime()

const bouncy = true
const enemy = true


func _ready():
	#seed the rng
	
	target = global_position


func _process(delta):
	#move towards wherever we've decided to target
	velocity = velocity.linear_interpolate(target - global_position, 1)
	
	#turn the bat in the direction it's moving
	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	move_and_slide(velocity, Vector2.UP)


#take damage
func hit(dmg):
	health -= dmg
	
	get_knocked()
	
	if health <= 0:
		die()


func die():
	queue_free()


func _on_RetargetTimer_timeout():
	if !getting_knocked:
		#attack the player if close enough
		if global_position.distance_to(player.global_position) < \
		attackDistance:
			target = player.global_position
		#otherwise, fly around aimlessly
		else:
			target = position + Vector2(Globals.rng.randi_range(-jiggle, jiggle), \
			Globals.rng.randi_range(-jiggle, jiggle))
	else:
		getting_knocked = false


#move away from the player for a sec after damaging them
func get_knocked():
	target = ((-player.global_position + global_position).normalized() * knockSpeed + global_position)
	getting_knocked = true
	$RetargetTimer.stop()
	$RetargetTimer.start()
