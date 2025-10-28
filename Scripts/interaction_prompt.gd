extends Label 

@export var offset: Vector2 = Vector2(4, -4)

func _process(delta: float) -> void:
	rotation = -owner.global_rotation
	global_position = owner.global_position + offset
