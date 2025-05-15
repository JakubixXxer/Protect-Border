extends CharacterBody2D
class_name Enemy

signal enemy_died
signal enemy_arrested

var SPEED = 60000

enum State{
	WALK,
	STUNNED
}

var enemyState = State.WALK

func arrest() -> void:
	emit_signal("enemy_arrested")
	die()

func die() -> void:
	emit_signal("enemy_died")
	queue_free()

func set_stune() -> void:
	enemyState = State.STUNNED
	%StunTimer.start()
	collision_mask = 0
	collision_layer = 3

func hitted() -> void:
	if enemyState == State.STUNNED:
		die()
	else:
		set_stune()

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	
	if enemyState == State.WALK:
		direction.x -= 1

	if direction != Vector2.ZERO or enemyState == State.WALK:
		direction = direction.normalized()
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_timer_timeout() -> void:
	if enemyState == State.STUNNED:
		enemyState = State.WALK
		collision_mask = 1
		collision_layer = 2


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player && enemyState == State.STUNNED:
		arrest()
	elif body is Enemy:
		body.SPEED = 30000
		%StunTimer.paused = true
	elif body is Bullet:
		die()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy && enemyState == State.STUNNED:
		body.SPEED = 60000
		%StunTimer.paused = false
		%StunTimer.start()
