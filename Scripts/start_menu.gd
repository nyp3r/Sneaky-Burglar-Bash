extends Control


func _on_start_button_pressed() -> void:
	#var scores_file = FileAccess.open("res://scores.txt", FileAccess.READ)
	#if scores_file == nuldl:
		#GlobalInfo.set_ingame_music()
		#get_tree().call_deferred("change_scene_to_file", "res://Scenes/introduction.tscn")
	
	GlobalInfo.set_ingame_music()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_settings_button_pressed() -> void:
	GlobalInfo.last_scene_path = scene_file_path
	print(GlobalInfo.last_scene_path)
	get_tree().change_scene_to_file("res://Scenes/Menus/settings_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
