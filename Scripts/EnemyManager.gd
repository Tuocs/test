extends Node2D


#each enemy will have a cost to spawn and total cost shouldnt exceed the pool
var pool = 20
var _cleared = false

func _process(delta):
	#if !_cleared && (all enemies are dead):
		#get_parent().clearRoom()
		#_cleared = true
	pass

func spawnEnemies():
	#come up with patterns to use
	
	#all same enemy
	#two enemy types, one ground one flying
	#completely random
	#
	#
	#
	
	#spawn enemies until total cost would exceed pool then stop
	pass

