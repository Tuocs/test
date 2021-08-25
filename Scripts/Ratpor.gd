extends KinematicBody2D


export var health = 100
export var attackDistance = 500
export var damage = 10
export var jumpPower = Vector2(300, -700)
export var knockSpeed = Vector2(300, -700)

var velocity = Vector2()
var onFloor = false
var xDirToPlayer = 1

onready var player = get_node("../../../PlayerScene/Player")

const enemy = true
const bouncy = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	onFloor = test_move(global_transform, Vector2(0,1))
	
	#find the direction to jump
	xDirToPlayer = global_position.direction_to(player.global_position).x
	
	if xDirToPlayer > 0:
		xDirToPlayer = 1
	else:
		xDirToPlayer = -1
	
	#make the ratpor fall
	if !onFloor:
		velocity.y += Globals.fallSpeed
	
	move_and_slide(velocity, Vector2.UP)
	
	if test_move(global_transform, Vector2(0,1)):
		velocity.x = 0

#take damage
func hit(dmg):
	health -= dmg
	
	get_knocked()
	
	if health <= 0:
		die()


func die():
	queue_free()


func get_knocked():
	velocity = knockSpeed * Vector2(-xDirToPlayer, 1)


func _on_JumpTimer_timeout():
	if onFloor && global_position.distance_to(player.global_position) < attackDistance:
		var jumpVariance = Vector2(Globals.rng.randi_range(-100, 100), Globals.rng.randi_range(-100, 100))
		velocity = (jumpPower + jumpVariance) * Vector2(xDirToPlayer, 1)
