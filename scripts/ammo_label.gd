extends Node

func refresh_ammo_label(ammo: int, max_ammo: int) -> void:
	$HUD/AmmoLabel.text = str(ammo) + "/" + str(max_ammo)

func show_progress_bar() -> void:
	$HUD/ReloadBar.visible = true

func hide_progress_bar() -> void:
	$HUD/ReloadBar.visible = false

func refresh_progress_bar(progress) -> void:
	$HUD/ReloadBar.value = progress
