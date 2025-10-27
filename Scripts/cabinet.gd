extends StaticBody2D
 
@onready var game_manager: GameManager = %GameManager
@onready var open_sprite: Sprite2D = $OpenSprite
@onready var closed_sprite: Sprite2D = $ClosedSprite

var can_hide = false 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		can_hide = true
		game_manager.toggle_interaction_prompt()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_hide = false
		game_manager.toggle_interaction_prompt()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and not game_manager.player_is_hidden and can_hide:
		game_manager.hide_player()
		open_sprite.visible = false
		closed_sprite.visible = true
	elif Input.is_action_just_pressed("interact") and game_manager.player_is_hidden:
		game_manager.unhide_player()
		open_sprite.visible = true
		closed_sprite.visible = false
