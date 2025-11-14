extends Marker2D
class_name ShootingPoint

const BULLET = preload("uid://pccngkaro4fo")
@onready var enemy: Enemy = %Enemy
@onready var shoot_audio: AudioStreamPlayer2D = $ShootAudio
@onready var game_manager: GameManager = %GameManager
@onready var reload_timer: Timer = $ReloadTimer
@onready var reload_audio: AudioStreamPlayer2D = $ReloadAudio
@onready var player = get_parent() as Player
var current_ammo := MAX_AMMO
var current_clip_size := MAX_CLIP_SIZE:
	set(value):
		if current_clip_size - value <= 0: 
			current_ammo -=  MAX_CLIP_SIZE
			current_clip_size = MAX_CLIP_SIZE
			reload()
		else:
			current_clip_size -= value

const MAX_AMMO = 20
const MAX_CLIP_SIZE = 5
var reloading := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and player.has_gun and not reloading and current_ammo > 0:
		current_clip_size -= 1
		shoot_audio.play()
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = player.rotation
		if enemy:
			bullet_instance.connect("body_entered", enemy._on_bullet_hit)

func reload():
	reload_timer.stop()
	reload_timer.start()
	reload_audio.play()
	reloading = true

func _on_reload_timer_timeout() -> void:
	reloading = false
