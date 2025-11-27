extends StaticBody2D

@onready var game_manager: GameManager = %GameManager
@onready var wrong_side_audio: AudioStreamPlayer2D = $WrongSideAudio
var in_wrong_side_range := false
var in_range := false
var door_opened := false

func _on_enter_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not door_opened:
		game_manager.enable_interaction_prompt()
		in_range = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and game_manager.player_has_key and in_range and not door_opened:
		rotation_degrees -= 90
		global_position.x += 13
		global_position.y += 13
		door_opened = true
		game_manager.disable_interaction_prompt()
	
	if Input.is_action_just_pressed("interact") and in_wrong_side_range:
		wrong_side_audio.play()

func _on_enter_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and not door_opened:
		game_manager.disable_interaction_prompt()
		in_range = false


func _on_wrong_side_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not door_opened:
		in_wrong_side_range = true
		game_manager.enable_interaction_prompt()


func _on_wrong_side_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and not door_opened:
		in_wrong_side_range = false
		game_manager.disable_interaction_prompt()
