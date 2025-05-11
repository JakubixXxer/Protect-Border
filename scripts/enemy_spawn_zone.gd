extends Path2D

func _physics_process(delta: float) -> void:
	position.y = %Player.position.y
