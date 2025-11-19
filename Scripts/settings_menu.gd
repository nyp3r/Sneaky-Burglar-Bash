extends Node2D


func _on_volume_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/volume_menu.tscn")


func _on_controls_button_pressed() -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
