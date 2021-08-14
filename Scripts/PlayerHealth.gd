extends Node

signal health_updated(Health)
signal killed()

export var MaxHealth = 100
onready var Health = MaxHealth setget _set_health
onready var healthbar = get_node("../UI/HealthBar")


#call this whenever player takes damage
func Dmg(ammount):
	_set_health(Health - ammount)


#do dying stuff here or with signal
func kill():
	pass


#set new health if health is not what it was send signal
func _set_health(value):
	var prv_health = Health
	Health = clamp(value, 0, MaxHealth)
	if Health != prv_health:
		emit_signal("health_updated", Health)
		if Health == 0:
			kill()
			emit_signal("killed")
