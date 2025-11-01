extends CharacterBody2D
class_name Enemy

const VISION_CONE_ANGLE := deg_to_rad(100)
const MAX_VIEW_DISTANE := 150
const ANGLE_BETWEEN_RAYS := deg_to_rad(10)

@onready var game_manager: GameManager = %GameManager
@onready var sprite: Sprite2D = $Sprite2D
@onready var path_follow: EnemyPath = $".."
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@export var hearing_radius: float = 300.0
@export var min_hear_volume: float = 0.0
@export var max_hear_volume: float = 0.5

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

func get_hearing_strength(player_pos: Vector2) -> float:
	var dist = global_position.distance_to(player_pos)
	if dist > hearing_radius:
		return 0.0
	var strength = 10 / float(dist)
	return strength * max_hear_volume

func _ready() -> void:
	generate_raycasts()
	print(AudioServer.bus_count)

func _physics_process(delta: float) -> void:
	if not chasing:
		for child in get_children():
			if child is RayCast2D:
				var ray = child as RayCast2D
				if ray.is_colliding() and ray.get_collider() is Player:
					path_follow.paused = true
					chasing = true
					reparent(owner)
					navigation_agent.target_position = target.global_position
					break
	
	if chasing:
		navigation_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		velocity = velocity.lerp(direction * 200, delta)
		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("reload_current_scene")


func _on_hunt_started() -> void:
	path_follow.paused = true
	chasing = true
	reparent(owner)
