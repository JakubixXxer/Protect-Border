extends CharacterBody2D
class_name Player

const DEFSPEED = 60000

var speed = DEFSPEED

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
