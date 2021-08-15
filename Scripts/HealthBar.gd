extends TextureProgress



func _ready():
	rect_position = get_node("/root").size / 2 - \
	rect_size * rect_scale


func _process(delta):
	pass


func _on_Health_health_updated(Health):
	value = Health


func _on_Health_maxHealth_updated(MaxHealth):
	max_value = MaxHealth
