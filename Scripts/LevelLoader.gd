extends Area2D

export var targetRoom = 1
export var side = 0


func _on_LevelLoader_body_entered(body):
	if body.has_method("player_move"):
		get_tree().get_root().get_node("Level").ChangeRoom(targetRoom, side)
