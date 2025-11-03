extends Node
class_name GameManager

@onready var enemy: CharacterBody2D = %Enemy
@onready var player: CharacterBody2D = %Player

var current_volume_score: int:
	get:
		var biggest: int = 0
		for source in volume_scores:
			if volume_scores[source] > biggest:
				biggest = volume_scores[source]
		return biggest
var volume_scores: Dictionary[AudioStreamPlayer2D, int]

var player_is_hidden = false

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

func _on_cabinet_player_exposed() -> void:
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false


func _on_cabinet_player_hid() -> void:
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true
