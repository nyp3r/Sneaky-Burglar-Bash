extends RayCast2D

@onready var enemy: Enemy = %Enemy

func _physics_process(_delta: float) -> void:
	if is_colliding():
		if get_collider().name == enemy.name:
			get_tree().change_scene_to_file("res://Scenes/fail_menu.tscn")
