extends Node2D


var last_dir_held = Vector2(1, 0)
export var sword_dmg = 10


func _ready():
	$Area2D.collision_layer = 0b0
	$Area2D.collision_mask = 0b0
	
	$Polygon2D.visible = false


func _process(delta):
	#find the held direction
	var dir_held = Vector2(0, 0)
	
	#if holding oppsite directions, they cancel out
	if Input.is_action_pressed("ui_up"):
		dir_held.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir_held.y += 1
	if dir_held.y == 0 && Input.is_action_pressed("ui_right"):
		dir_held.x += 1
	if dir_held.y == 0 && Input.is_action_pressed("ui_left"):
		dir_held.x -= 1
	
	#update the last direction held, or default to it if no direction is held
	if dir_held.length() == 0:
		dir_held = last_dir_held
	elif dir_held.x != 0:
		last_dir_held.x = dir_held.x
	
	#actually swing, if not already swinging
	if Input.is_action_pressed("attack") && $AttackTimer.is_stopped():
		$Area2D.collision_layer = 32
		$Area2D.collision_mask = 32
		
		$Polygon2D.visible = true
		
		$AttackTimer.start()
		
		rotation_degrees = rad2deg(dir_held.angle())


#reset the attack
func _on_AttackTimer_timeout():
	$Area2D.collision_layer = 0b0
	$Area2D.collision_mask = 0b0
	
	$Polygon2D.visible = false


func _on_Area2D_body_entered(body):
	#reduce the health of enemies on hit
	if body.has_method("hit"):
		body.hit(sword_dmg)
