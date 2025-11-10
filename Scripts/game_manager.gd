extends Node
class_name GameManager

@onready var enemy: Enemy = %Enemy
@export var player: Player

var current_volume_score: int:
	get:
		var biggest: int = 0
		for source in volume_scores:
			if volume_scores[source] > biggest:
				biggest = volume_scores[source]
		return biggest
var volume_scores: Dictionary[AudioStreamPlayer2D, int]

var player_is_hidden = false

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible

func hide_player():
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true
	enemy._on_player_hid()

func expose_player():
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false
	enemy._on_player_exposed()
