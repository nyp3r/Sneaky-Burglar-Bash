extends Node2D
class_name PlayerUI

@export var offset: Vector2 = Vector2(4, -4)

func _process(_delta: float) -> void:
	global_position = owner.global_position + offset
