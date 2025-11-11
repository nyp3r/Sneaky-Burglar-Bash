extends StaticBody2D
 
@onready var game_manager: GameManager = %GameManager
@onready var toggles: Node2D = $Toggles
@onready var closed_collision: CollisionShape2D = $ClosedCollisionShape
@onready var opened_collision: CollisionPolygon2D = $OpenedCollisionPolygon
@onready var open_close_timer: Timer = $OpenCloseTimer
@onready var open_audio_stream: AudioStreamPlayer2D = $OpenAudioStream
@onready var close_audio_stream: AudioStreamPlayer2D = $CloseAudioStream
@onready var open_audio_timer: Timer = $OpenAudioTimer
@onready var close_audio_timer: Timer = $CloseAudioTimer

enum volume_scores {
	OPEN = 10,
	CLOSE = 10
}

var is_in_range = false

var can_open_close = true

func _ready() -> void:
	open_audio_timer.wait_time = open_audio_stream.stream.get_length()
	close_audio_timer.wait_time = close_audio_stream.stream.get_length()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		is_in_range = true
		game_manager.toggle_interaction_prompt()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_in_range = false
		game_manager.toggle_interaction_prompt()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and not game_manager.player_is_hidden and is_in_range:
		if can_open_close:
			game_manager.hide_player()
			close_cabinet()
	elif Input.is_action_just_pressed("interact") and game_manager.player_is_hidden and is_in_range:
		if can_open_close:
			game_manager.expose_player()
			open_cabinet()

func toggle_open_close():
	for child in toggles.get_children():
		var node = child as Node2D
		node.visible = !node.visible
	closed_collision.disabled = !closed_collision.disabled
	opened_collision.disabled = !opened_collision.disabled


func close_cabinet():
	open_close_timer.start()
	can_open_close = false
	toggle_open_close()
	close_audio_stream.play()
	close_audio_timer.start()
	game_manager.volume_scores[close_audio_stream] = volume_scores.CLOSE


func open_cabinet():
	open_close_timer.start()
	can_open_close = false
	toggle_open_close()
	open_audio_stream.play()
	open_audio_timer.start()
	game_manager.volume_scores[open_audio_stream] = volume_scores.OPEN


func _on_open_close_timer_timeout() -> void:
	can_open_close = true


func _on_close_audio_timer_timeout() -> void:
	if not game_manager.volume_scores.erase(close_audio_stream):
		print("cabinet: close audio stream did not exist")


func _on_open_audio_timer_timeout() -> void:
	game_manager.volume_scores.erase(open_audio_stream)
