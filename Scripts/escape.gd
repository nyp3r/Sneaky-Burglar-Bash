extends RayCast2D

@onready var enemy: Enemy = %Enemy

func _physics_process(_delta: float) -> void:
	if is_colliding():
		if get_collider().name == enemy.name:
			GlobalInfo.set_menu_music()
			get_tree().change_scene_to_file("res://Scenes/Menus/fail_menu.tscn")
