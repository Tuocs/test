extends Node

signal maxHealth_updated(MaxHealth)
signal health_updated(Health)
signal killed()

export var MaxHealth = 100
onready var Health = MaxHealth setget _set_health

func _ready():
	emit_signal("health_updated", Health)
	emit_signal("maxHealth_updated", MaxHealth)


#call this whenever player takes damage
func Dmg(ammount):
	_set_health(Health - ammount)


#do dying stuff here or with signal
func kill():
	get_tree().change_scene("res://Scenes/Menu.tscn")


#set new health if health is not what it was send signal
func _set_health(value):
	var prv_health = Health
	Health = clamp(value, 0, MaxHealth)
	if Health != prv_health:
		emit_signal("health_updated", Health)
		if Health == 0:
			kill()
			emit_signal("killed")
