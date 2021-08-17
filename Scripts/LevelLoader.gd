extends Area2D

#the target room number on room manger to go to
export var targetRoom = 1

#the side coming from or going to i havnt decided
export var side = 0


func _on_LevelLoader_body_entered(body):
	if body.has_method("player_move"):#shitty shitty way of doing this but it works, checks if player
		get_tree().get_root().get_node("Level").ChangeRoom(targetRoom, side)
