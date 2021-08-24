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

#idk, does weird stuff to make a 2d array work
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
	
	#this is temporary if you want to try a specific room layout
	IdMatrix[0][0] = 2
	IdMatrix[1][0] = 1
	IdMatrix[2][0] = 1
	IdMatrix[3][0] = 1
	IdMatrix[4][0] = 1
	IdMatrix[0][1] = 0
	IdMatrix[1][1] = 0
	IdMatrix[2][1] = 0
	IdMatrix[3][1] = 0
	IdMatrix[4][1] = 0
	IdMatrix[0][2] = 0
	IdMatrix[1][2] = 0
	IdMatrix[2][2] = 0
	IdMatrix[3][2] = 0
	IdMatrix[4][2] = 0
	IdMatrix[0][3] = 0
	IdMatrix[1][3] = 0
	IdMatrix[2][3] = 0
	IdMatrix[3][3] = 0
	IdMatrix[4][3] = 0
	IdMatrix[0][4] = 0
	IdMatrix[1][4] = 0
	IdMatrix[2][4] = 0
	IdMatrix[3][4] = 0
	IdMatrix[4][4] = 0

#will take the IdMatrix array and generate the rooms into the world
func LoadLayout():
	for x in range(width):
		for y in range(height):
			if IdMatrix[x][y] == 1:
				LoadRoom(Hallway, x, y)
			if IdMatrix[x][y] == 2:
				LoadRoom(Start, x, y)



#spawn in a individual room into the world
func LoadRoom(roomtype, x, y):
	RoomMatrix[x][y] = roomtype.instance()
	add_child(RoomMatrix[x][y])
	move_child(RoomMatrix[x][y], 0)
	RoomMatrix[x][y].global_position = Vector2(x*3500, y*3500)
	RoomMatrix[x][y].setXY(x,y)


#move player to room
#side was to show what side of room you entered from so you can spawn by the door
func ChangeRoom(x, y, side):
	get_node("PlayerScene/Player").global_position = Vector2((x * 3500)+200,(y * 3500)+400)
	RoomMatrix[x][y].setLoaded(true)
	print("entering (" , x , ", " , y , ")")
