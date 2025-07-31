extends CanvasLayer

class_name HUD

static var arrested: int = 0
static var killed: int = 0
static var escaped: int = 0

func update_arrested() -> void:
	arrested += 1
	$ArrestedLabel.text = str(arrested)

func update_killed() -> void:
	killed += 1
	$KilledLabel.text = str(killed)

func update_escaped() -> void:
	escaped += 1
	$EscapedLabel.text = str(escaped)

func _physics_process(delta: float) -> void:
	%Timer.text = str(int(%GameTimer.time_left)) + " sec"
