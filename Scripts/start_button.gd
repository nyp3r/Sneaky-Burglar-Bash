extends Button


func _on_pressed() -> void:
	GlobalInfo.set_ingame_music()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
