extends Node2D

@export var TIME_CHANGER: int = 60

# Enemy Spawn
func _on_timer_timeout() -> void:
	%PathFollow2D.progress_ratio = randf()
	$TimerOfEnemies.wait_time = %GameTimer.time_left / TIME_CHANGER
	
	var enemy_scene = preload("res://scenes/enemy.tscn").instantiate()
	enemy_scene.global_position = %PathFollow2D.global_position
	$".".add_child(enemy_scene)
