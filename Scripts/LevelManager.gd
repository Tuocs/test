extends Node2D

#types of rooms
var Start = load ("res://Scenes/Rooms/TestLevel.tscn")
var Hallway = load ("res://Scenes/Rooms/TestLevel - Copy.tscn")



var width = 5
var height = 5
var IdMatrix = []
var RoomMatrix = []


# Called when the node enters the scene tree for the first time.
func _ready():
	arraySetup()
	GenerateLayout()
	LoadLayout()
	
	ChangeRoom(0, 0, 0)

func arraySetup():
	for x in range(width):
		IdMatrix.append([])
		for y in range(height):
			IdMatrix[x].append(0)
	
	for x in range(width):
		RoomMatrix.append([])
		for y in range(height):
			RoomMatrix[x].append(0)


func GenerateLayout():
	IdMatrix[0][0] = 2
	IdMatrix[1][0] = 1
	IdMatrix[2][0] = 1
	IdMatrix[3][0] = 1
	IdMatrix[4][0] = 1
	IdMatrix[0][1] = 1
	IdMatrix[1][1] = 1
	IdMatrix[2][1] = 1
	IdMatrix[3][1] = 1
	IdMatrix[4][1] = 1
	IdMatrix[0][2] = 1
	IdMatrix[1][2] = 1
	IdMatrix[2][2] = 1
	IdMatrix[3][2] = 1
	IdMatrix[4][2] = 1
	IdMatrix[0][3] = 1
	IdMatrix[1][3] = 1
	IdMatrix[2][3] = 1
	IdMatrix[3][3] = 1
	IdMatrix[4][3] = 1
	IdMatrix[0][4] = 1
	IdMatrix[1][4] = 1
	IdMatrix[2][4] = 1
	IdMatrix[3][4] = 1
	IdMatrix[4][4] = 1

func LoadLayout():
	for x in range(width):
		for y in range(height):
			if IdMatrix[x][y] == 1:
				LoadRoom(Hallway, x, y)
			if IdMatrix[x][y] == 2:
				LoadRoom(Start, x, y)



#spawn in a room into the world
func LoadRoom(roomtype, x, y):
	RoomMatrix[x][y] = roomtype.instance()
	add_child(RoomMatrix[x][y])
	move_child(RoomMatrix[x][y], 0)
	RoomMatrix[x][y].global_position = Vector2(x*3500, y*3500)


#move player to room
#side was to show what side of room you entered from so you can spawn by the door
func ChangeRoom(x, y, side):
	get_node("PlayerScene/Player").global_position = Vector2((x * 3500)+200,(y * 3500)+400)
