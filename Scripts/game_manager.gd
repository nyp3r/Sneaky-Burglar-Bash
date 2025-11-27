extends Node
class_name GameManager

var time := 0.0

signal player_hid
signal player_exposed

@onready var enemy: Enemy = %Enemy
@export var player: Player
@onready var gun_drawer_marker: Node2D = %GunDrawerMarker
@onready var key_marker: Node2D = %KeyMarker
const PAUSE_MENU = preload("uid://c2as8aqc7jbyy")

var current_volume_score: int:
	get:
		var biggest: int = 0
		for source in volume_scores:
			if volume_scores[source] > biggest:
				biggest = volume_scores[source]
		return biggest
var volume_scores: Dictionary[AudioStreamPlayer2D, int]

var player_is_hidden := false
var player_has_gun_in_hand := false
var player_has_key := false

func _ready() -> void:
	gun_drawer_marker.visible = false
	key_marker.visible = true

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible

func enable_interaction_prompt():
	player.interaction_prompt.visible = true

func disable_interaction_prompt():
	player.interaction_prompt.visible = false

func _process(delta: float) -> void:
	time += delta

func save_score():
	var latest_score_file = FileAccess.open("user://latest_score.txt", FileAccess.WRITE)
	var file: FileAccess
	file = FileAccess.open("user://scores.txt", FileAccess.READ_WRITE)
	if file == null:
		file = FileAccess.open("user://scores.txt", FileAccess.WRITE)
	file.seek_end()
	file.store_float(time)
	latest_score_file.store_float(time)
	file.close()
	latest_score_file.close()


func _on_player_exposed() -> void:
	player_is_hidden = false


func _on_player_hid() -> void:
	player_is_hidden = true 
