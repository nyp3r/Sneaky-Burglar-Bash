extends Area2D

@onready var marker_canvas_layer: CanvasLayer = %MarkerCanvasLayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
		marker_canvas_layer.visible = false
