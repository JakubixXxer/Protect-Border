extends CharacterBody2D
class_name Enemy

signal enemy_respawned
signal enemy_died
signal enemy_arrested
signal enemy_escaped

const SPRITE_NUMBERS: int = 2
const DEFSPEED: int = 60000

var speed: int = DEFSPEED

var stateComponent

# Future randomizing skin
func _ready() -> void:
	$Sprite2D.texture = load("res://assets/enemy" + str(randi_range(1, SPRITE_NUMBERS)) + ".png")
	
	stateComponent = $Components/StateComponent
	stateComponent.set_walk()

func arrest() -> void:
	emit_signal("enemy_arrested")
	queue_free()

func die() -> void:
	emit_signal("enemy_died")
	queue_free()

func escape() -> void:
	emit_signal("enemy_escaped")
	queue_free()

func set_stune() -> void:
	stateComponent.set_stune()
	$StunTimer.start()
	$CollisionShape2D.call_deferred("set_disabled", true)
	z_index = -1

func set_normal() -> void:
	stateComponent.set_walk()
	$CollisionShape2D.call_deferred("set_disabled", false)
	z_index = 0

func hitted() -> void:
	if stateComponent.get_state() == stateComponent.States.STUNNED:
		die()
	else:
		set_stune()

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	
	if stateComponent.get_state() == stateComponent.States.WALK:
		direction.x -= 1

	if direction != Vector2.ZERO or stateComponent.get_state() == stateComponent.States.WALK:
		direction = direction.normalized()
		velocity = direction * speed * delta
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_timer_timeout() -> void:
	if stateComponent.get_state() == stateComponent.States.STUNNED:
		set_normal()

## Player/Enemy contact
func _on_area_2d_body_entered(body: Node2D) -> void:
	if stateComponent.get_state() == stateComponent.States.STUNNED:
		body.speed = body.DEFSPEED / 2
		$StunTimer.paused = true
		
		if body is Player:
			arrest()


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.speed = body.DEFSPEED
	
	$StunTimer.paused = false
	$StunTimer.start()
##
