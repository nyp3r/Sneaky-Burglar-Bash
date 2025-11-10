extends StaticBody2D
class_name Bed

var is_in_range := false
var interaction_delayed := false

@onready var game_manager: GameManager = %GameManager
@onready var interaction_delay_timer: Timer = $InteractionDelayTimer
@onready var point_light: PointLight2D = $PointLight

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		game_manager.toggle_interaction_prompt()
		is_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		game_manager.toggle_interaction_prompt()
		is_in_range = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and not game_manager.player_is_hidden and is_in_range:
		if not interaction_delayed:
			game_manager.hide_player()
			interaction_delay_timer.start()
			interaction_delayed = true
			point_light.visible = true
	elif Input.is_action_just_pressed("interact") and game_manager.player_is_hidden and is_in_range:
		if not interaction_delayed:
			game_manager.expose_player()
			interaction_delay_timer.start()
			interaction_delayed = true
			point_light.visible = false


func _on_interaction_delay_timer_timeout() -> void:
	interaction_delayed = false
