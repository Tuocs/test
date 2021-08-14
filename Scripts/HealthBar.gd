extends TextureProgress

#make sure healthbar starts with some health even without update
func _ready():
	value = get_node("../../Health").Health
	max_value = get_node("../../Health").MaxHealth



func update_maxhealth(MaxHealth):
	max_value = MaxHealth

func _on_Health_health_updated(Health):
	value = Health
