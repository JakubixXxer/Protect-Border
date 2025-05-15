extends Area2D

class_name Bullet

const SPEED: int = 5000
var direction := Vector2.ZERO

func _ready() -> void:
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_body_entered(node: Node) -> void:
	if node is Enemy:
		node.hitted()
		queue_free()
	elif node is Area2D:
		node.get_parent().hitted()


func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Enemy:
		parent.hitted()
		queue_free()
