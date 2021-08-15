extends Node

export var path = "res://Scenes/Menu.tscn"


#egg
func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene(path)

#emmett scene
func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Level.tscn")

#scout scene
func _on_Play_2_pressed():
	get_tree().change_scene("res://Scenes/Node2D - Copy.tscn")

#settings?
func _on_Thing_pressed():
	pass # Replace with function body.

#exit game
func _on_Exit_pressed():
	get_tree().quit()
