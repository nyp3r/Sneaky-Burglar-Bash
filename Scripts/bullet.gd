extends Area2D
class_name Bullet

const SPEED := 300

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_body_entered(_body: Node2D) -> void:
	for connection in body_entered.get_connections():
		body_entered.disconnect(connection["callable"])
	queue_free()
