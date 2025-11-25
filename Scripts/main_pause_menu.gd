extends Control

@onready var canvas_layer: CanvasLayer = $".."

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		canvas_layer.visible = !canvas_layer.visible
		get_tree().paused = !get_tree().paused


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/start_menu.tscn")


func _on_resume_button_pressed() -> void:
	Input.action_press("pause")


func _on_settings_button_pressed() -> void:
	GlobalInfo.last_scene_path = "res://Scenes/game.tscn"
	get_tree().change_scene_to_file("res://Scenes/Menus/settings_menu.tscn")
