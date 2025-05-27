extends Area2D

class_name Pistol

const maxAmmo = 20
var ammo = 20

func reload() -> void:
	ammo = maxAmmo
	%HUD.update_magazine(ammo)

func shoot() -> void:
	if $ShootInterval.time_left == 0:
		if ammo > 0:
			var bullet_scene = preload("res://scenes/bullet.tscn").instantiate()

			# Bullet in marker position
			bullet_scene.global_position = %BulletSpawnMarker.global_position

			# Calculate direction for mouse and set this
			bullet_scene.look_at(%DirectionMarker.global_position)
			bullet_scene.direction = bullet_scene.transform.x.normalized()

			# Add to scene
			get_tree().current_scene.add_child(bullet_scene)
			
			# Magazine changing
			ammo -= 1
			%HUD.update_magazine(ammo)
			
			# Interval between shoots
			$ShootInterval.start()
			
			# If magazine is empty and player is not reloading -> Reload weapon
			if ammo == 0 && $Reload.time_left == 0:
				$Reload.start()

func _input(event):
	# If player press lmb -> shoot
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
	# If the button is reload button -> reload
	if event.is_action("g_reload"):
		ammo = 0
		%HUD.update_magazine(ammo)
		$Reload.start()
		
		# Show time left to reload
		#while(%Reload.time_left):
			#%ReloadTime.text = str(int(%Reload.time_left) + "s")

func _on_reload_timeout() -> void:
	reload()
