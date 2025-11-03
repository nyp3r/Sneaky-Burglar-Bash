extends CharacterBody2D
class_name Enemy

enum sound {
	occluded = 5,
	direct = 10,
}

const VISION_CONE_ANGLE := deg_to_rad(100)
const MAX_VIEW_DISTANE := 150
const ANGLE_BETWEEN_RAYS := deg_to_rad(10)

@onready var game_manager: GameManager = %GameManager
@onready var sprite: Sprite2D = $Sprite2D
@onready var path_follow: EnemyPath = $".."
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sound_ray_cast: RayCast2D = $SoundRayCast
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var target: Player

const MAX_SPACIAL_VOLUME = 300
var chasing = false

func generate_raycasts() -> void:
	var ray_count := VISION_CONE_ANGLE / ANGLE_BETWEEN_RAYS
	
	for i in ray_count:
		var ray := RayCast2D.new()
		var angle := ANGLE_BETWEEN_RAYS * (i - ray_count / 2.0)
		ray.target_position = Vector2.UP.rotated(angle) * MAX_VIEW_DISTANE
		add_child(ray)
		ray.enabled = true

func _ready() -> void:
	generate_raycasts()

func _physics_process(delta: float) -> void:
	sound_ray_cast.target_position = sound_ray_cast.to_local(target.global_position)
	if not game_manager.player_is_hidden:
		if sound_ray_cast.is_colliding() and not sound_ray_cast.get_collider().is_class("CharacterBody2D"):
			AudioServer.set_bus_effect_enabled(3, 0, true)
			audio.volume_db = sound.occluded
		else:
			AudioServer.set_bus_effect_enabled(3, 0, false)
			audio.volume_db = sound.direct
		
	
	if not chasing:
		for child in get_children():
			if child is RayCast2D:
				var ray = child as RayCast2D
				if ray.is_colliding() and ray.get_collider() is Player:
					print("enemy.gd: enemy sees player")
					start_hunt()
					break
	else:
		navigation_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		velocity = velocity.lerp(direction * 200, delta)
		move_and_slide()
	
	if get_spacial_volume_score() < 50:
		start_hunt()

func start_hunt():
	path_follow.paused = true
	chasing = true
	reparent(owner) 

func get_spacial_volume_score() -> int: 
	var distance_to_player = global_position.distance_to(target.global_position)
	return distance_to_player / game_manager.current_volume_score

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("reload_current_scene")

func _on_cabinet_player_exposed() -> void:
	for child in get_children():
			if child is RayCast2D:
				child.enabled = true


func _on_cabinet_player_hid() -> void:
	for child in get_children():
			if child is RayCast2D:
				child.enabled = false
	audio.volume_db = sound.occluded
