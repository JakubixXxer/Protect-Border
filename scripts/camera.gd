extends Camera2D

func _physics_process(delta: float) -> void:
	# Set camera on player position every frame
	# To do: To make it not every frame, but every time player moves
	position.y = %Player.position.y
