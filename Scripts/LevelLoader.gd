extends Area2D


export var side = 0



func _on_LevelLoader_body_entered(body):
	if body.has_method("player_move"):#shitty shitty way of doing this but it works, checks if player
		get_parent().setLoaded(false)
		
		if side == 0:
			get_tree().get_root().get_node("Level").ChangeRoom(get_parent().getX(), get_parent().getY()+1, 2)
		if side == 1:
			get_tree().get_root().get_node("Level").ChangeRoom(get_parent().getX()+1, get_parent().getY(), 3)
		if side == 2:
			get_tree().get_root().get_node("Level").ChangeRoom(get_parent().getX(), get_parent().getY()-1, 0)
		if side == 3:
			get_tree().get_root().get_node("Level").ChangeRoom(get_parent().getX()-1, get_parent().getY(), 1)
