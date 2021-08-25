extends Reference


class_name TwoDimArray

var col #columns
var row #rows

var data = []


func _init(x, y):
	col = x
	row = y


func index(x, y):
	return data[col * y + x]


func assign(x, y, value):
	data[col * y + x] = value


func display():
	for j in row:
		
		var s = ""
		
		for i in col:
			s.append(index(i, j))
		
		print(s)
