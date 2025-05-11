extends CharacterBody2D
class_name Player

const SPEED = 60000
const maxAmmo = 20
var ammo = 20

func hitted() -> void:
	print("Player got hitted")

func shoot() -> void:
	if ammo > 0:
		var bullet_scene = preload("res://scenes/bullet.tscn").instantiate()

		# ustaw pozycję pocisku w miejscu gracza
		bullet_scene.global_position = %Marker2D.global_position

		# oblicz kierunek na mysz i przekaż do pocisku
		var dir = (get_global_mouse_position() - global_position).normalized()
		bullet_scene.direction = dir

		# dodaj do sceny
		get_tree().current_scene.add_child(bullet_scene)
		ammo -= 1
		
		%HUD.shoot(ammo, maxAmmo)
	else:
		%Reload.start()


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2.ZERO
	
	look_at(get_global_mouse_position())

	move_and_slide()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()


func _on_timer_timeout() -> void:
	ammo = maxAmmo
	%HUD.shoot(ammo, maxAmmo)
