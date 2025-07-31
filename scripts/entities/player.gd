extends CharacterBody2D
class_name Player

signal player_respawned
signal player_died
signal player_shooted
signal player_reloaded

const DEFSPEED: int = 60000

var speed: int

func _ready() -> void:
	var weapon = $Components/WeaponComponent
	weapon.give_weapon(weapon.weapons["Pistol"])
	speed = DEFSPEED

func hitted() -> void:
	print("Player got hitted")

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


func _input(event: InputEvent) -> void:
	var node = get_node_or_null("Components/WeaponComponent")
	if node:
		var weapon = get_node_or_null("Pistol")
			
		# If player press lmb -> shoot
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Player shooted")
			weapon.shoot()
			emit_signal("player_shooted")
			
		# If the button is reload button -> reload
		if event.is_action("g_reload"):
			print("Player reloaded")
			weapon.reload()
			emit_signal("player_reloaded")
			
			# Show time left to reload
			#while(%Reload.time_left):
				#%ReloadTime.text = str(int(%Reload.time_left) + "s")
