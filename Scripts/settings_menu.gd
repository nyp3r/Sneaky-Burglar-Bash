extends Control


func _on_volume_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/volume_menu.tscn")


func _on_controls_button_pressed() -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(GlobalInfo.last_scene_path)
