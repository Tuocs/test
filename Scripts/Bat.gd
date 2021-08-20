extends KinematicBody2D


export var health = 30
export var damage = 10
export var moveSpeed = 300
export var attackDistance = 200
export var jiggle = 200

var velocity = Vector2()
var target = Vector2()

onready var player = get_node("../../PlayerScene/Player")
var rng = RandomNumberGenerator.new()
var date_time = OS.get_datetime()

const bouncy = true
const enemy = true


func _ready():
	rng.set_seed(date_time["hour"] * date_time["minute"] * date_time["second"])


func _process(delta):
	
	print(velocity)
	
	move_and_slide(velocity, Vector2.UP)


func hit(dmg):
	health -= dmg
	
	if health <= 0:
		die()


func die():
	queue_free()


func _on_RetargetTimer_timeout():
	if global_position.distance_to(player.global_position) < \
	attackDistance:
		target = player.global_position
	else:
		target = position + Vector2(rng.randi_range(-jiggle, jiggle), rng.randi_range(-jiggle, jiggle))
	
	velocity = target - global_position
