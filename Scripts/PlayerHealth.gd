extends Node

signal health_updated(Health)
signal killed()

export var MaxHealth = 100
onready var Health = MaxHealth setget _set_health
onready var healthbar = get_node("../UI/HealthBar")



func _ready():
	healthbar.update_maxhealth(MaxHealth)


func _process(delta):
	
	if Input.is_action_just_pressed("ui_down"):
		Dmg(10)


func Dmg(ammount):
	_set_health(Health - ammount)

func kill():
	pass

func _set_health(value):
	var prv_health = Health
	Health = clamp(value, 0, MaxHealth)
	if Health != prv_health:
		emit_signal("health_updated", Health)
		if Health == 0:
			kill()
			emit_signal("killed")
