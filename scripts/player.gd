extends CharacterBody2D
class_name Player

const DEFSPEED = 60000
const maxAmmo = 20

var speed = DEFSPEED
var ammo = 20

func hitted() -> void:
	print("Player got hitted")

func reload() -> void:
	ammo = maxAmmo
	%HUD.update_magazine(ammo)

func shoot() -> void:
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
		
		if ammo == 0 && %Reload.time_left == 0:
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
		velocity = direction * speed * delta
	else:
		velocity = Vector2.ZERO
	
	look_at(get_global_mouse_position())

	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
	if event.is_action("g_reload"):
		ammo = 0
		%HUD.update_magazine(ammo)
		%Reload.start()

func _on_timer_timeout() -> void:
	reload()
