extends CharacterBody2D
class_name Enemy

const SPEED = 60000

enum State{
	WALK,
	STUNNED,
	DEAD
}

var enemyState = State.WALK

func hitted() -> void:
	if enemyState == State.STUNNED:
		queue_free()
	enemyState = State.STUNNED
	%StunTimer.start()
	
	# Layer or mask change soon

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
