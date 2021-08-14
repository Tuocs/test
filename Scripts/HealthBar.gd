extends TextureProgress


func _on_Health_health_updated(Health):
	value = Health


func _on_Health_maxHealth_updated(MaxHealth):
	max_value = MaxHealth
