extends Spatial

export var rotSpeed = 100
onready var timer = get_node("Timer1")
onready var cam = get_node("Camera2")
var rotate = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(11.3)
	timer.connect("timeout", self, "TimerTimeout")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rotate):
		rotate_y(rotSpeed * delta)


func TimerTimeout():
	rotate = true
	cam.current = true
