extends Node

class_name Health

@export var maxHealth: int
var currentHealth: int

func damage(damage: int):
	currentHealth -= damage

func heal(heal: int):
	damage(-heal)

func set_max_health(health: int):
	currentHealth = health

func die() -> void:
	if get_parent().has_component("PlayerControlled"):
		emit_signal("player_died")
	elif get_parent().has_component("AI"):
		emit_signal("enemy_died")
		get_parent().queue_free()
