extends Area2D

@onready var game_manager: GameManager = %GameManager
@onready var gun_drawer_marker: Node2D = %GunDrawerMarker
@onready var key_marker: Node2D = %KeyMarker

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.player_has_key = true
		key_marker.visible = false
		gun_drawer_marker.visible = true
		queue_free()
