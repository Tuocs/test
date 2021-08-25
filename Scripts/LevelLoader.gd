extends Area2D


export var side = 0

onready var baseRoomNode = $"../.."
onready var baseLevelNode = get_tree().get_root().get_node("Level")


func _on_LevelLoader_body_entered(body):
	if body.has_method("player_move"): #shitty shitty way of doing this but it works, checks if player
		baseRoomNode.setLoaded(false)
		
		if side == 0:
			baseLevelNode.ChangeRoom(baseRoomNode.getX(), baseRoomNode.getY()+1, 2)
		if side == 1:
			baseLevelNode.ChangeRoom(baseRoomNode.getX()+1, baseRoomNode.getY(), 3)
		if side == 2:
			baseLevelNode.ChangeRoom(baseRoomNode.getX(), baseRoomNode.getY()-1, 0)
		if side == 3:
			baseLevelNode.ChangeRoom(baseRoomNode.getX()-1, baseRoomNode.getY(), 1)
