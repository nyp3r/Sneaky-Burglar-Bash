extends Area2D
class_name LightSwitch

@onready var game_manager: GameManager = %GameManager
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var can_toggle_lights = false

signal lights_toggled

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_toggle_lights = true
		game_manager.toggle_interaction_prompt()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_toggle_lights = false
		game_manager.toggle_interaction_prompt()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_toggle_lights:
			lights_toggled.emit()
			audio.play()
