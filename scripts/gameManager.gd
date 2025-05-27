extends Node2D

class_name Game

@export var TIME_CHANGER: int = 15

func _on_enemy_arrested() -> void:
	%HUD.update_arrested()

func _on_enemy_died() -> void:
	%HUD.update_killed()

func _on_enemy_escaped() -> void:
	%HUD.update_escaped()

# Enemy Spawn
func _on_timer_timeout() -> void:
	# Randomizing position for enemies
	%PathFollow2D.progress_ratio = randf()
	$TimerOfEnemies.wait_time = %GameTimer.time_left / TIME_CHANGER
	
	# Spawning enemies
	var enemy_scene = preload("res://scenes/enemy.tscn").instantiate()
	enemy_scene.global_position = %PathFollow2D.global_position
	$".".add_child(enemy_scene)
	
	# Signals connections
	enemy_scene.enemy_arrested.connect(_on_enemy_arrested)
	enemy_scene.enemy_died.connect(_on_enemy_died)
	enemy_scene.enemy_escaped.connect(_on_enemy_escaped)

func _on_escaping_enemies_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Enemy:
		parent.escape()
	elif parent is Bullet:
		parent.queue_free()
