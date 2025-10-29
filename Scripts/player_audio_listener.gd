extends AudioListener2D

func _physics_process(_delta: float) -> void:
	global_position = get_tree().get_first_node_in_group("Player").global_position
