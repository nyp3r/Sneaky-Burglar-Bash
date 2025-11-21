extends Marker2D
class_name ShootingPoint

const VOLUME_SCORE = 50

const BULLET = preload("uid://pccngkaro4fo")
@onready var reload_animation: AnimatedSprite2D = %ReloadAnimation
@onready var enemy: Enemy = %Enemy
@onready var shoot_audio: AudioStreamPlayer2D = $ShootAudio
@onready var game_manager: GameManager = %GameManager
@onready var reload_timer: Timer = $ReloadTimer
@onready var reload_audio: AudioStreamPlayer2D = $ReloadAudio
@onready var ammo_label: Label = %AmmoLabel
@onready var shoot_volume_score_timer: Timer = $ShootVolumeScoreTimer
@onready var player = get_parent() as Player
var current_ammo := MAX_AMMO
var current_clip_size := MAX_CLIP_SIZE

const MAX_AMMO = 20
const MAX_CLIP_SIZE = 5
var reloading := false

func _ready() -> void:
	shoot_volume_score_timer.wait_time = shoot_audio.stream.get_length()

func _process(_delta: float) -> void:
	if player.has_gun and not reloading and current_ammo + current_clip_size > 0 and game_manager.player_has_gun_in_hand:
		if Input.is_action_just_pressed("shoot"):
			if current_clip_size > 0:
				current_clip_size -= 1
				ammo_label.text = str(current_clip_size) + "/" + str(current_ammo)
				game_manager.volume_scores[shoot_audio] = VOLUME_SCORE
				shoot_volume_score_timer.start()
				shoot_audio.play()
				var bullet_instance = BULLET.instantiate()
				get_tree().root.add_child(bullet_instance)
				bullet_instance.global_position = global_position
				bullet_instance.rotation = player.rotation
				if enemy:
					bullet_instance.connect("body_entered", enemy._on_bullet_hit)
			else: reload()
		if Input.is_action_just_pressed("reload") and current_clip_size < MAX_CLIP_SIZE:
			reload()

func reload():
	reload_timer.stop()
	reload_timer.start()
	reload_audio.play()
	reload_animation.visible = true
	reload_animation.play("default", reload_timer.wait_time)
	reloading = true

func _on_reload_timer_timeout() -> void:
	reloading = false
	reload_animation.visible = false
	current_ammo -= MAX_CLIP_SIZE
	current_clip_size = MAX_CLIP_SIZE
	ammo_label.text = str(current_clip_size) + "/" + str(current_ammo)


func _on_shoot_volume_score_timer_timeout() -> void:
	game_manager.volume_scores.erase(shoot_audio)
