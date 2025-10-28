extends StaticBody2D
 
@onready var game_manager: GameManager = %GameManager
@onready var toggles: Node2D = $Toggles
@onready var closed_collision: CollisionShape2D = $ClosedCollisionShape
@onready var opened_collision: CollisionPolygon2D = $OpenedCollisionPolygon

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
		toggle_open_close()
	elif Input.is_action_just_pressed("interact") and game_manager.player_is_hidden:
		game_manager.unhide_player()
		toggle_open_close()

func toggle_open_close():
	for child in toggles.get_children():
		var node = child as Node2D
		node.visible = !node.visible
	closed_collision.disabled = !closed_collision.disabled
	opened_collision.disabled = !opened_collision.disabled
