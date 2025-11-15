extends CharacterBody2D
class_name Enemy

@onready var current_health := MAX_HEALTH
const MAX_HEALTH = 10

var speed: int
const WALK_SPEED = 50
const SPRINT_SPEED = 125
var accelaration = 2

enum sound {
	occluded = 5,
	direct = 10,
}

const VISION_CONE_ANGLE := deg_to_rad(100)
const MAX_VIEW_DISTANE := 100
const ANGLE_BETWEEN_RAYS := deg_to_rad(10)

@onready var game_manager: GameManager = %GameManager
@onready var sprite: Sprite2D = $Sprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sound_ray_cast: RayCast2D = $SoundRayCast
@onready var footstep_audio: AudioStreamPlayer2D = $FootstepAudio
@onready var voice_audio: AudioStreamPlayer2D = $VoiceAudio
@onready var laugh_timer: Timer = $LaughTimer
@onready var navigation_region: NavigationRegion2D = %NavigationRegion2D
@onready var cover_navigation: NavigationRegion2D = %CoverNavigation
@export var target: Player
@onready var spawner_timer: Timer = $SpawnerTimer

@export var walk_sound: AudioStreamMP3
@export var run_sound: AudioStreamMP3
@export var laugh_sound: AudioStreamMP3

const MAX_SPACIAL_VOLUME = 300
var chasing = false
var is_behind_cover = false

func generate_raycasts() -> void:
	var ray_count := VISION_CONE_ANGLE / ANGLE_BETWEEN_RAYS
	
	for i in ray_count:
		var ray := RayCast2D.new()
		var angle := ANGLE_BETWEEN_RAYS * (i - ray_count / 2.0)
		ray.target_position = Vector2.RIGHT.rotated(angle) * MAX_VIEW_DISTANE
		add_child(ray)
		ray.enabled = true

func _ready() -> void:
	generate_raycasts()
	speed = WALK_SPEED

func _physics_process(delta: float) -> void:
	sound_ray_cast.target_position = sound_ray_cast.to_local(target.global_position)
	if not game_manager.player_is_hidden:
		if sound_ray_cast.is_colliding() and not sound_ray_cast.get_collider().is_class("CharacterBody2D"): 
			AudioServer.set_bus_effect_enabled(3, 0, true)
			footstep_audio.volume_db = sound.occluded
		else:
			AudioServer.set_bus_effect_enabled(3, 0, false)
			footstep_audio.volume_db = sound.direct
	
	
	if not chasing:
		for child in get_children():
			if child is RayCast2D:
				var ray = child as RayCast2D
				if ray.is_colliding() and ray.get_collider() is Player and ray.name != sound_ray_cast.name:
					start_hunt()
					break
	
	
	if not navigation_agent.is_navigation_finished():
		look_at(navigation_agent.get_next_path_position())
		var direction := (navigation_agent.get_next_path_position() - global_position).normalized()
		var steer = (direction * speed - velocity) * 4.0
		velocity += steer * delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	var spacial_volume_score = get_spacial_volume_score()
	if spacial_volume_score < 10 and spacial_volume_score >= 0:
		start_hunt()

func start_hunt():
	if not chasing:
		footstep_audio.stop()
		footstep_audio.stream = run_sound
		footstep_audio.play()
		chasing = true
		speed = SPRINT_SPEED
		if not is_behind_cover:
			navigation_agent.target_position = NavigationServer2D.region_get_random_point(navigation_region.get_rid(), 0, false)

func get_spacial_volume_score() -> int:
	var distance_to_player = global_position.distance_to(target.global_position)
	return distance_to_player / game_manager.current_volume_score

func _on_bullet_hit(body):
	if body.name != name:
		return
	
	current_health -= 1
	if current_health < 0:
		
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and not game_manager.player_is_hidden:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/fail_menu.tscn")

func _on_player_exposed() -> void:
	for child in get_children():
			if child is RayCast2D:
				child.enabled = true


func _on_player_hid() -> void:
	for child in get_children():
			if child is RayCast2D:
				child.enabled = false
	footstep_audio.volume_db = sound.occluded


func _on_laugh_timer_timeout() -> void:
	if not voice_audio.playing and randi_range(0, 10) == 0:
		voice_audio.stream = laugh_sound
		voice_audio.play()


func _on_spawner_timer_timeout() -> void:
	var navigation_region_rid := navigation_region.get_rid()
	position = NavigationServer2D.region_get_random_point(navigation_region_rid, 0, false)
	navigation_agent.target_position = NavigationServer2D.region_get_random_point(navigation_region.get_rid(), 0, false)


func _on_navigation_finished() -> void:
	if not chasing:
		navigation_agent.target_position = NavigationServer2D.region_get_random_point(navigation_region.get_rid(), 0, false)
