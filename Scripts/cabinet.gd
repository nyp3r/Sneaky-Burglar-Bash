extends StaticBody2D
 
@onready var game_manager: GameManager = %GameManager
@onready var toggles: Node2D = $Toggles
@onready var closed_collision: CollisionShape2D = $ClosedCollisionShape
@onready var opened_collision: CollisionPolygon2D = $OpenedCollisionPolygon
@onready var open_close_timer: Timer = $OpenCloseTimer
@onready var open_audio_stream: AudioStreamPlayer2D = $OpenAudioStream
@onready var close_audio_stream: AudioStreamPlayer2D = $CloseAudioStream

var can_hide = false

var can_open_close = true

signal player_hid
signal player_exposed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		can_hide = true
		game_manager.toggle_interaction_prompt()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_hide = false
		game_manager.toggle_interaction_prompt()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and not game_manager.player_is_hidden and can_hide:
		if can_open_close:
			player_hid.emit()
	elif Input.is_action_just_pressed("interact") and game_manager.player_is_hidden:
		if can_open_close:
			player_exposed.emit()

func toggle_open_close():
	for child in toggles.get_children():
		var node = child as Node2D
		node.visible = !node.visible
	closed_collision.disabled = !closed_collision.disabled
	opened_collision.disabled = !opened_collision.disabled


func _on_player_hid() -> void:
	open_close_timer.start()
	can_open_close = false
	toggle_open_close()
	close_audio_stream.play()


func _on_player_exposed() -> void:
	open_close_timer.start()
	can_open_close = false
	toggle_open_close()
	open_audio_stream.play()


func _on_open_close_timer_timeout() -> void:
	can_open_close = true
