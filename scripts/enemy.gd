extends CharacterBody2D
class_name Enemy

signal enemy_died
signal enemy_arrested

const SPRITE_NUMBERS: int = 2
const DEFSPEED = 60000

var speed = DEFSPEED

enum State{
	WALK,
	STUNNED
}

var enemyState = State.WALK

# Future randomizing skin
#func _ready() -> void:
#	$Sprite2D.texture = load("res://assets/enemy" + str(randi_range(1, SPRITE_NUMBERS)) + ".png")

func arrest() -> void:
	emit_signal("enemy_arrested")
	queue_free()

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
func _on_area_2d_body_entered(body: Node2D) -> void:
	if enemyState == State.STUNNED:
		body.speed = body.DEFSPEED / 2
		$StunTimer.paused = true
		
		if body is Player:
			arrest()


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.speed = body.DEFSPEED
	
	$StunTimer.paused = false
	$StunTimer.start()
##
