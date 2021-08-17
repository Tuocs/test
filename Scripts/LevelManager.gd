extends Node2D

var Start = load ("res://Scenes/Rooms/TestLevel.tscn")
var Second = load ("res://Scenes/Rooms/TestLevel - Copy.tscn")

var roomArray = [null, null, null, null, null, null, null, null, null]
var roomCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	LoadRoom(Start)
	LoadRoom(Second)
	ChangeRoom(0, 0)


#spawn in a room
func LoadRoom(roomtype):
	roomArray[roomCount] = roomtype.instance()
	add_child(roomArray[roomCount])
	roomArray[roomCount].position = Vector2(0, roomCount*1500)
	move_child(roomArray[roomCount], 0)
	roomCount += 1

#move player to room
func ChangeRoom(room, side):
	get_node("PlayerScene/Player").position = Vector2(100, 100 + (room * 1500))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
