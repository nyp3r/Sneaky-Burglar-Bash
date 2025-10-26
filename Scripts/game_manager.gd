extends Node
class_name GameManager

@onready var enemy: CharacterBody2D = %Enemy
@onready var player: CharacterBody2D = %Player
@export var volume_linear: float

var player_is_hidden = false

func _process(delta: float) -> void:
	volume_linear = player.audio.volume_linear

func hide_player(body: PhysicsBody2D):
	player.visible = false
	player.movement_enabled = false
	player_is_hidden = true

func unhide_player(body: PhysicsBody2D):
	player.visible = true
	player.movement_enabled = true
	player_is_hidden = false

func toggle_interaction_prompt():
	player.interaction_prompt.visible = !player.interaction_prompt.visible
