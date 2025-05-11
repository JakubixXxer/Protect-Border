extends CanvasLayer

func shoot(ammo: int, maxAmmo: int) -> void:
	%AmmoLabel.text = str(ammo) + "/" + str(maxAmmo)

func _physics_process(delta: float) -> void:
	%Timer.text = str(int(%GameTimer.time_left))
