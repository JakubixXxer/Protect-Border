extends Area2D

class_name Pistol

@export var max_ammo: int = 20
var ammo: int
var ammo_in_chamber: bool

func _ready():
	ammo = max_ammo
	$AmmoLabel.refresh_ammo_label(ammo, max_ammo)

# This function set ammo to 0
func reload() -> void:
	if ammo > 0:
		ammo_in_chamber = true
	ammo = 0
	$Reload.start()
	$AmmoLabel.refresh_ammo_label(ammo, max_ammo)
	$AmmoLabel.show_progress_bar()

func shoot() -> void:
	if $ShootInterval.time_left != 0:
		return
	if ammo > 0:
		var bullet_scene = preload("res://scenes/entities/bullet.tscn").instantiate()

		# Bullet in marker position
		bullet_scene.global_position = %BulletSpawnMarker.global_position

		# Calculate direction for mouse and set this
		bullet_scene.look_at(%DirectionMarker.global_position)
		bullet_scene.direction = bullet_scene.transform.x.normalized()

		# Add to scene
		get_tree().current_scene.add_child(bullet_scene)
		
		# Loose one ammo
		ammo -= 1
		
		# Update to HUD
		$AmmoLabel.refresh_ammo_label(ammo, max_ammo)
		
		# Interval between shoots
		$ShootInterval.start()
		
		# If magazine is empty and player is not reloading -> Reload weapon
		if ammo == 0 && $Reload.time_left == 0:
			$Reload.start()

func _on_reload_timeout() -> void:
	ammo = max_ammo
	if ammo_in_chamber:
		ammo += 1
	ammo_in_chamber = false
	$AmmoLabel.refresh_ammo_label(ammo, max_ammo)
	$AmmoLabel.hide_progress_bar()

func _process(delta: float) -> void:
	if $Reload.time_left != 0:
		$AmmoLabel.refresh_progress_bar(100 - $Reload.time_left * 50)
