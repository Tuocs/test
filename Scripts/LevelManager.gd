extends Node2D

#types of rooms
var Start = load ("res://Scenes/Rooms/TestLevel.tscn")
var Hallway = load ("res://Scenes/Rooms/TestLevel - Copy.tscn")

var width = 11
var height = 7
var roomDensity = .35
var numRooms = int(width * height * roomDensity)

# ROOM DOOR LAYOUT in LayoutMatrix
# MSB 0bwxyz LSB
#          w
#     z  center  x
#          y

var LayoutMatrix = TwoDimArray.new(width, height)
var IdMatrix = []
var RoomMatrix = []


# Called when the node enters the scene tree for the first time.
func _ready():
	array_setup()
	generate_layout()
	load_layout()
	
	change_room(0, 0, 0)


#idk, does weird stuff to make a 2d array work
func array_setup():
	for x in range(width):
		IdMatrix.append([])
		for y in range(height):
			IdMatrix[x].append(0)
	
	for x in range(width):
		RoomMatrix.append([])
		for y in range(height):
			RoomMatrix[x].append(0)


func generate_layout():
	#fill the room layout with zeroes (no rooms)
	for i in width:
		for j in height:
			LayoutMatrix.assign(i, j, 0)
	
	#add the first room
	LayoutMatrix.assign(int(width / 2), int(height / 2), 0b1111)
	
	#send out a recursive call in each of the four cardinal directions,
	#to make branches from the center
	for i in 4:
		var dir = Vector2(0, 0)
		
		match i:
			0:
				dir.y = -1
			1:
				dir.x = 1
			2:
				dir.y = 1
			3:
				dir.x = -1
		
		generate_recurse(dir, Vector2(int(width / 2), int(height / 2)), \
		 int(numRooms / 4), false) 


func generate_recurse(dir, pos, roomsToFill, split):
	if roomsToFill > 0:
		pos += dir
		
		#don't go out of bounds
		if pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height:
			return
		
		#add a hallway back to the last room
		var doorSides = 0b0000
		
		if dir.y == 1:
			doorSides |= 0b1000
		elif dir.y == -1:
			doorSides |= 0b0010
		elif dir.x == 1:
			doorSides |= 0b0001
		elif dir.x == -1:
			doorSides |= 0b0100
		
		#add split(s) if possible, or decide if you should on the next recursion
		if split:
			split = false
			
			var splitClockwise = randi() % 2
			var splitCounterclockwise = randi() % 2
			
			if splitClockwise:
				#mult then swap goes clockwise
				var newDir = dir * Vector2(-1, 1)
				newDir = Vector2(newDir.y, newDir.x)
				
				#TODO: decide how many rooms to give splits
			
			#guarantees at least one split
			if splitCounterclockwise || !splitCounterclockwise:
				pass #swap then mult goes counterclockwise
			
			pass
		elif randi() % 2:
			split = true
		
		#add a hallway going to the next room, if there are more rooms to generate
		roomsToFill -= 1
		
		if roomsToFill > 0:
			if dir.y == -1:
				doorSides |= 0b1000
			elif dir.y == 1:
				doorSides |= 0b0010
			elif dir.x == -1:
				doorSides |= 0b0001
			elif dir.x == 1:
				doorSides |= 0b0100
		
		#recurse
		generate_recurse(dir, pos, roomsToFill, split)
	
	#base case: no more rooms left to make
	else:
		return


#will take the IdMatrix array and generate the rooms into the world
func load_layout():
	IdMatrix[0][0] = 2
	
	for x in range(width):
		for y in range(height):
			if IdMatrix[x][y] == 1:
				load_room(Hallway, x, y)
			if IdMatrix[x][y] == 2:
				load_room(Start, x, y)


#spawn in a individual room into the world
func load_room(roomtype, x, y):
	RoomMatrix[x][y] = roomtype.instance()
	add_child(RoomMatrix[x][y])
	move_child(RoomMatrix[x][y], 0)
	RoomMatrix[x][y].global_position = Vector2(x*3500, y*3500)
	RoomMatrix[x][y].setXY(x,y)


#move player to room
#side was to show what side of room you entered from so you can spawn by the door
func change_room(x, y, side):
	get_node("PlayerScene/Player").global_position = Vector2((x * 3500)+200,(y * 3500)+400)
	RoomMatrix[x][y].setLoaded(true)
	print("entering (" , x , ", " , y , ")")
