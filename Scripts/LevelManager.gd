extends Node2D

#types of rooms
var Start = load ("res://Scenes/Rooms/TestLevel.tscn")
var Hallway = load ("res://Scenes/Rooms/TestLevel - Copy.tscn")

var width = 5
var height = 5

var LayoutMatrix = PoolIntArray()
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
	#generate some random ints
	for i in 32:
		LayoutMatrix.push_back(Globals.rng.randi())
	
	#get rid of doors that don't go anywhere
	for i in height + 1:
		var row = LayoutMatrix[(height * 2) + 1]
		
		for j in width + 1:
			if j == 0 || j == width || \
			(row & 1 << (j * 2) + 1) == 0 || \
			(row & 1 << (j * 2) - 1) == 0:
				LayoutMatrix[(height * 2) + 1] = 0
	
	for i in height + 1:
		var nextRow = LayoutMatrix[(height * 2) + 1]
		var lastRow = LayoutMatrix[(height * 2) - 1]
		
		for j in width + 1:
			if j == 0 || j == width || \
			nextRow & 1 << (j * 2) + 1 == 0 || \
			nextRow & 1 << (j * 2) + 1 == 0:
				LayoutMatrix[height * 2] = 0
	
	var s = ""
	for i in height * 2:
		for j in width * 2:
			s += str((LayoutMatrix[i] & 1 << j))
		print(s)
		s = ""


#will take the IdMatrix array and generate the rooms into the world
func LoadLayout():
	IdMatrix[0][0] = 2
	
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
