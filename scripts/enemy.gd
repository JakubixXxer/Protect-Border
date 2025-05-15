extends CharacterBody2D
class_name Enemy

signal enemy_died
signal enemy_arrested

const DEFSPEED = 60000
var speed = DEFSPEED

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
	$StunTimer.start()
	$CollisionShape2D.call_deferred("set_disabled", true)
	z_index = -1

func set_normal() -> void:
	enemyState = State.WALK
	$CollisionShape2D.call_deferred("set_disabled", false)
	z_index = 0

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
		velocity = direction * speed * delta
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_timer_timeout() -> void:
	if enemyState == State.STUNNED:
		set_normal()

## Player/Enemy contact
## @deprecated This doesn't work
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Body entered area2d")
	
	body.SPEED = body.DEFSPEED / 2
	$StunTimer.paused = true
	
	if body is Player:
		print("It's a player")
		arrest()


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.SPEED = body.DEFSPEED
	
	$StunTimer.paused = false
	$StunTimer.start()
##
