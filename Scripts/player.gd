extends CharacterBody2D
class_name Player

var movement_enabled = true

const WALK_SPEED = 100
const SNEAK_SPEED = 50
const RUN_SPEED = 200
@onready var speed = WALK_SPEED

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var interaction_prompt: Label = $InteractionPrompt

const BASE_VOLUME = 0.5

func get_input() -> Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction

func _physics_process(delta):
	var input_direction = get_input()
	if input_direction != Vector2.ZERO:
		rotation = input_direction.angle() + deg_to_rad(90)
	
	if movement_enabled:
		if move_and_slide():
			resolve_collisions()
	
	if input_direction == Vector2.ZERO or not movement_enabled:
		audio.stop()
	
	if input_direction != Vector2.ZERO and not audio.playing and movement_enabled:
		audio.play()
	
	if movement_enabled:
		if Input.is_action_just_pressed("sneak"):
			speed = SNEAK_SPEED
		elif Input.is_action_just_released("sneak"):
			speed = WALK_SPEED
		elif Input.is_action_just_pressed("run"):
			speed = RUN_SPEED
		elif Input.is_action_just_released("run"):
			speed = WALK_SPEED
	
	audio.pitch_scale = float(speed) / float(WALK_SPEED)
	audio.volume_linear = float(speed) / float(WALK_SPEED) * BASE_VOLUME
	if input_direction == Vector2.ZERO:
		audio.volume_linear = 0.0


func resolve_collisions() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider()as RigidBody2D
		if body:
			body.apply_force(-100.0 * collision.get_normal())
