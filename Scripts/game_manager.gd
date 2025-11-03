extends Node
class_name GameManager

@onready var enemy: CharacterBody2D = %Enemy
@onready var player: CharacterBody2D = %Player
@onready var progress_bar: ProgressBar = $"../UI/ProgressBar"
var current_volume_score: float = 0.0
var max_volume_score: float = 0.0

const VOLUME_SCORE_MAX = 15.5
const VOLUME_MAX = 1.0
var player_is_hidden = false

signal hunt_started

func _process(_delta: float) -> void:
	pass
	#var volume_current = spectrum_analyzer.get_magnitude_for_frequency_range(0, 10000).length()
	#if volume_current > VOLUME_MAX or current_volume_score > VOLUME_SCORE_MAX:
		#hunt_started.emit()
	 #
	#var distance_to_player = enemy.global_position.distance_to(player.global_position)
	#
	#var spacial_volume = 1 / volume_current * distance_to_player
	#if progress_bar != null:
		#progress_bar.value = spacial_volume
	#
	#if spacial_volume < VOLUME_MAX:
		#hunt_started.emit()

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible


func _on_hunt_started() -> void:
	pass # Replace with function body.


func _on_cabinet_player_exposed() -> void:
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false


func _on_cabinet_player_hid() -> void:
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true
