extends Control

func _ready() -> void:
	FileAccess.open("resd://scores.txt", FileAccess.WRITE)

func _on_play_again_button_pressed() -> void:
	GlobalInfo.set_ingame_music()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_settings_button_pressed() -> void:
	GlobalInfo.last_scene_path = scene_file_path
	get_tree().change_scene_to_file("res://Scenes/Menus/settings_menu.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/start_menu.tscn")
