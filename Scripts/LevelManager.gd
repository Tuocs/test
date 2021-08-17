extends Node2D

#types of rooms
var Start = load ("res://Scenes/Rooms/TestLevel.tscn")
var Second = load ("res://Scenes/Rooms/TestLevel - Copy.tscn")

#list of rooms on floor
var roomArray = [null, null, null, null, null, null, null, null, null]
#current highest room
var roomCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	LoadRoom(Start)
	LoadRoom(Second)#this causes a problem with enemys tracking player before they go to room, should load later probably 
						  #or just add the line of sight check before they more twords player, should do both
	ChangeRoom(0, 0)


#spawn in a room into the world
func LoadRoom(roomtype):
	roomArray[roomCount] = roomtype.instance()
	add_child(roomArray[roomCount])
	move_child(roomArray[roomCount], 0)
	roomArray[roomCount].global_position = Vector2(0, roomCount*1500)
	roomCount += 1

#move player to room
#side was to show what side of room you entered from so you can spawn by the door
func ChangeRoom(room, side):
	get_node("PlayerScene/Player").global_position = Vector2(200,(room * 1500)+400)
