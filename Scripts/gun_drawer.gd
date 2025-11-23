extends StaticBody2D

signal gun_picked_up
signal getting_gun

@onready var game_manager: GameManager = %GameManager
@onready var gun_drawer_marker: Node2D = %GunDrawerMarker
@onready var pickup_audio: AudioStreamPlayer2D = $PickupAudio
@onready var shake_audio: AudioStreamPlayer2D = $ShakeAudio
@onready var unlock_audio: AudioStreamPlayer2D = $UnlockAudio
@onready var unlock_timer: Timer = $UnlockTimer
@onready var pickup_timer: Timer = $PickupTimer

@onready var empty_animation: AnimatedSprite2D = $EmptyAnimation
@onready var filled_animation: AnimatedSprite2D = $FilledAnimation
@onready var animation: AnimatedSprite2D

var is_in_range := false
var is_open := false
var locked := true

func _ready() -> void:
	animation = filled_animation
	unlock_timer.wait_time = unlock_audio.stream.get_length()
	pickup_timer.wait_time = pickup_audio.stream.get_length()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.enable_interaction_prompt()
		is_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.disable_interaction_prompt()
		is_in_range = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_range and not animation.is_playing():
		if locked and not game_manager.player_has_key and not shake_audio.playing:
			shake_audio.play()
		elif locked and game_manager.player_has_key:
			unlock()
		elif not locked:
			if not is_open:
				animation.play("open")
				is_open = true
			else:
				animation.play("close")
				is_open = false

func unlock():
	gun_drawer_marker.visible = false
	getting_gun.emit()
	unlock_audio.play()
	unlock_timer.start()

func _on_unlock_timer_timeout() -> void:
	animation.play("open")
	is_open = true


func _on_filled_animation_animation_finished() -> void:
	locked = false
	pickup_audio.play()
	pickup_timer.start()
 

func _on_pickup_timer_timeout() -> void:
	gun_picked_up.emit()
	animation.visible = false
	animation = empty_animation
	animation.visible = true
