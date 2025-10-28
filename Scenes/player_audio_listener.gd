extends AudioListener2D

func _physics_process(delta: float) -> void:
	rotation = -owner.global_rotation
	global_position = get_tree().get_first_node_in_group("Player").global_position
