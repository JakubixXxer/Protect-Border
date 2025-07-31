extends Node

class_name State
enum States{
	WALK,
	STUNNED
}
var actualState: States

func get_state() -> States:
	return actualState

func set_walk() -> void:
	actualState = States.WALK

func set_stune() -> void:
	actualState = States.STUNNED
