extends Node
class_name GameManager

@onready var enemy: CharacterBody2D = %Enemy
@onready var player: CharacterBody2D = %Player
var volume_score: float = 0.0

const VOLUME_SCORE_MAX = 15.5
const VOLUME_MAX = 1.0
var player_is_hidden = false

signal hunt_started

func _process(_delta: float) -> void:
	if AudioServer.get_bus_volume_db(2) > VOLUME_MAX or volume_score > VOLUME_SCORE_MAX:
		hunt_started.emit()

func hide_player():
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true

func unhide_player():
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible


func _on_hunt_started() -> void:
	pass # Replace with function body.
