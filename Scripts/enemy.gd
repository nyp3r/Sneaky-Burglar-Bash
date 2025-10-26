extends CharacterBody2D

@onready var spectrum_analyzer := AudioServer.get_bus_effect_instance(2, 0) as AudioEffectSpectrumAnalyzerInstance
@onready var game_manager: Node = %GameManager
@onready var sprite: Sprite2D = $Sprite2D

@export var hearing_radius: float = 300.0
@export var min_hear_volume: float = 0.0
@export var max_hear_volume: float = 0.5

const MAX_SPACIAL_VOLUME = 300

func get_hearing_strength(player_pos: Vector2) -> float:
	var dist = global_position.distance_to(player_pos)
	if dist > hearing_radius:
		return 0.0
	var strength = 10 / float(dist)
	return strength * max_hear_volume

func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var distance_to_player = global_position.distance_to(player.global_position)
	
	var spacial_volume = 1 / game_manager.volume_linear * distance_to_player
	if spacial_volume < MAX_SPACIAL_VOLUME:
		get_tree().reload_current_scene()
