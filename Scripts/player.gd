extends CharacterBody2D
class_name Player

signal picked_up_gun

var movement_enabled = true

@export var sneak_sound: AudioStreamMP3
@export var walk_sound: AudioStreamMP3
@export var run_sound: AudioStreamMP3

enum sound_score {
	SNEAK = 5,
	WALK = 10,
	RUN = 20
}

const WALK_SPEED = 100
const SNEAK_SPEED = 50
const RUN_SPEED = 200
var running = false
var sneaking = false

@onready var speed = WALK_SPEED

@onready var unarmed_sprite: Sprite2D = $UnarmedSprite
@onready var armed_sprite: Sprite2D = $ArmedSprite
@onready var game_manager: GameManager = %GameManager
@onready var audio: AudioStreamPlayer2D = $FootstepAudio
@onready var interaction_prompt: Label = $InteractionPrompt

var has_gun = false

func get_input() -> Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction

func _physics_process(_delta):
	var input_direction = get_input()
	if input_direction != Vector2.ZERO:
		rotation = input_direction.angle() + deg_to_rad(90)
	
	if movement_enabled:
		if move_and_slide():
			resolve_collisions()
	
	look_at(get_global_mouse_position())
	
	if input_direction == Vector2.ZERO or not movement_enabled:
		audio.stop()
		game_manager.volume_scores[audio] = 0
	
	if input_direction != Vector2.ZERO and not audio.playing and movement_enabled:
		audio.play()
		match audio.stream:
			sneak_sound:
				game_manager.volume_scores[audio] = sound_score.SNEAK
			
			walk_sound:
				game_manager.volume_scores[audio] = sound_score.WALK 
			run_sound:
				game_manager.volume_scores[audio] = sound_score.RUN
	
	if movement_enabled:
		if Input.is_action_just_pressed("sneak"):
			sneaking = true
			speed = SNEAK_SPEED
			audio.stream = sneak_sound
		elif Input.is_action_just_released("sneak"):
			sneaking = false
			speed = WALK_SPEED
			audio.stream = walk_sound
		elif Input.is_action_just_pressed("run"):
			running = true
			speed = RUN_SPEED
			audio.stream = run_sound
		elif Input.is_action_just_released("run"):
			running = false
			speed = WALK_SPEED
			audio.stream = walk_sound 


func resolve_collisions() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider() as RigidBody2D
		if body:
			body.apply_force(-100.0 * collision.get_normal())


func _on_teddy_bear_2_body_entered(body: Node2D) -> void:
	if body.name == name:
		picked_up_gun.emit()
		has_gun = true
