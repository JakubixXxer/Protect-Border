extends CanvasLayer

class_name HUD

static var arrested: int = 0
static var killed: int = 0

func update_arrested() -> void:
	arrested += 1
	$ArrestedLabel.text = "Arrested: " + str(arrested)

func update_killed() -> void:
	killed += 1
	$KilledLabel.text = "Killed: " + str(killed)

func update_magazine(ammo: int) -> void:
	%AmmoLabel.text = str(ammo) + "/" + str(Player.maxAmmo)

func _physics_process(delta: float) -> void:
	%Timer.text = str(int(%GameTimer.time_left)) + " sec"
