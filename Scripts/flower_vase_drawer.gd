extends StaticBody2D
class_name FlowerVaseDrawer

@onready var game_manager: GameManager = %GameManager


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	
	
