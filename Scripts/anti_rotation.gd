extends Node2D

func _process(_delta: float) -> void:
	var parent = get_parent() as Node2D
	rotation = -parent.global_rotation
