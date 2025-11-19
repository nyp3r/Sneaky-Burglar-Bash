extends Node
class_name GlobalData

var last_scene_path: String
var ingame_music_volume: float = 0.5
var menu_music_volume: float = 1.0

func set_ingame_music():
	AudioServer.set_bus_volume_linear(1, ingame_music_volume)

func set_menu_music():
	AudioServer.set_bus_volume_linear(1, menu_music_volume)
