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

			# Bullet in player position
			bullet_scene.global_position = %Marker2D.global_position

			# Calculate direction for mouse and set this
			var dir = (get_global_mouse_position() - global_position).normalized()
			bullet_scene.direction = dir

			# Add to scene
			get_tree().current_scene.add_child(bullet_scene)
			
			# Magazine changing
			ammo -= 1
			%HUD.update_magazine(ammo)
			
			$ShootInterval.start()
			
			if ammo == 0 && $Reload.time_left == 0:
				$Reload.start()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
	if event.is_action("g_reload"):
		ammo = 0
		%HUD.update_magazine(ammo)
		$Reload.start()
		
#		while(%Reload.time_left):
#			%ReloadTime.text = str(int(%Reload.time_left) + "s")

func _on_reload_timeout() -> void:
	reload()
