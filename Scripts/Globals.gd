extends Node


export var accMult = 65
export var fallSpeed = 70
export var maxYVel = 2000

var rng = RandomNumberGenerator.new()
var date_time = OS.get_datetime()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.set_seed(date_time["hour"] * date_time["minute"] * date_time["second"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
