extends Control

var master = AudioServer.get_bus_index("Master")

var sfx = AudioServer.get_bus_index("SFX")
var ingame_sfx = AudioServer.get_bus_index("Ingame SFX")
var menu_sfx = AudioServer.get_bus_index("Menu SFX")

var music = AudioServer.get_bus_index("Music")
var ingame_music = AudioServer.get_bus_index("Ingame Music")
var menu_music = AudioServer.get_bus_index("Menu Music")


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx, value)


func _on_ingame_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(ingame_sfx, value)


func _on_menu_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(menu_sfx, value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music, value)


func _on_ingame_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(ingame_music, value)


func _on_menu_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(menu_music, value)
