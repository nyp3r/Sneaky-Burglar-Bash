extends Button

func _on_button_down() -> void:
	GlobalInfo.set_ingame_music()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
