extends Node2D


var x = 0
var y = 0
var loaded = false
var cleared = false

export var doorMask = 0b0100


func isLoaded():
	return loaded
func isCleared():
	return cleared


func setLoaded(loadState):
	loaded = loadState
	if cleared == false:
#		get_node("Enemies").spawnEnemies()
		pass
func clearRoom():
	cleared = true


func getX():
	return x
func getY():
	return y
func setXY(_x, _y):
	x = _x
	y = _y
