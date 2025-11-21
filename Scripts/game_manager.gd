extends Node
class_name GameManager

var time := 0.0

@onready var enemy: Enemy = %Enemy
@export var player: Player
const PAUSE_MENU = preload("uid://c2as8aqc7jbyy")

var current_volume_score: int:
	get:
		var biggest: int = 0
		for source in volume_scores:
			if volume_scores[source] > biggest:
				biggest = volume_scores[source]
		return biggest
var volume_scores: Dictionary[AudioStreamPlayer2D, int]

var player_is_hidden = false
var player_has_gun_in_hand = false

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible

func hide_player():
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true
	if enemy:
		enemy._on_player_hid()

func expose_player():
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false 
	if enemy:
		enemy._on_player_exposed()

func _process(delta: float) -> void:
	time += delta
