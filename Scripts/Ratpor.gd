extends KinematicBody2D


export var health = 100
export var attackDistance = 200
export var damage = 10

var velocity = Vector2()

onready var player = get_node("../../PlayerScene/Player")

const enemy = true
const bouncy = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if global_position.distance_to(player.global_position) < attackDistance:
		var xDirToPlayer = global_position.direction_to(player.global_position).x
		
		if xDirToPlayer > 0:
			xDirToPlayer = 1
		else:
			xDirToPlayer = -1
		
		


#take damage
func hit(dmg):
	health -= dmg
	
	if health <= 0:
		die()


func die():
	queue_free()
