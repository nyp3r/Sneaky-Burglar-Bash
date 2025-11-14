extends RayCast2D

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var player = get_tree().get_first_node_in_group("Player") as Player
		if get_collider().name == player.name and player.has_gun:
			get_tree().change_scene_to_file("res://Scenes/success_menu.tscn")
