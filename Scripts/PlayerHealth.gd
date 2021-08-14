extends Node

export var MaxHealth = 100
export var Health = 100
onready var healthbar = get_node("../UI/HealthBar")



func _ready():
	healthbar.update_health(Health)
	healthbar.update_maxhealth(MaxHealth)


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		Health -= 10
		healthbar.update_health(Health)
