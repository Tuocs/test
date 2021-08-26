extends Node


class_name TwoDimArray

var col #columns
var row #rows

var data = Array()


func _init(x, y):
	col = x
	row = y
	
	data.resize(col * row)


func index(x, y):
	return data[col * y + x]


func assign(x, y, value):
	data[col * y + x] = value


func display():
	for j in row:
		
		var s = ""
		
		for i in col:
			s += str(index(i, j)) + '\t'
		
		print(s)


func display_as_binary():
	for j in row:
		
		var s = ""
		
		for i in col:
			var entry = index(i, j)
			
			for k in 4:
				s += str((entry >> (3 - k)) & 0b1)
			
			s += '|'
		
		print(s)


func display_as_filled():
	for j in row:
		
		var s = ""
		
		for i in col:
			if index(i, j) != 0:
				s += '█'
			else:
				s += ' '
		
		print(s)
