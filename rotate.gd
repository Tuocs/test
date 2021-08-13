extends Spatial

export var rotSpeed = 100
onready var timer = get_node("Timer1")
onready var cam = get_node("Camera2")
var rotateS1 = false
var rotateS2 = false
var rotateS3 = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(11.3)
	timer.connect("timeout", self, "TimerTimeout")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rotateS1):
		rotate_y(rotSpeed * delta)
	if (rotateS2):
		rotate_y(rotSpeed * 10 * delta)


func TimerTimeout():
	if (rotateS2):
		rotateS3 = true
		rotateS2 = false
	if (rotateS1 && !rotateS2 && !rotateS3):
		rotateS2 = true
		timer.start(.4)
	if (!rotateS1):
		rotateS1 = true
		timer.start(3)
	cam.current = true

