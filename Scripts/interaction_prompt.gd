extends Control

@export var offset: Vector2 = Vector2(4, -4)

func _physics_process(_delta: float) -> void:
	global_position = owner.global_position + offset
