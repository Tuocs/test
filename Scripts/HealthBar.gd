extends TextureProgress

func _ready():
	value = get_node("../../Health").Health

func update_maxhealth(MaxHealth):
	max_value = MaxHealth

func _on_Health_health_updated(Health):
	value = Health
