extends State
class_name Unarmed

@onready var player = owner as Player
@onready var gun_light: PointLight2D = %GunLight
@onready var flash_light: PointLight2D = %FlashLight
@onready var game_manager: GameManager = $"../../../GameManager"

func enter():
	player.unarmed_sprite.visible = true
	player.armed_sprite.visible = false
	gun_light.visible = false
	flash_light.visible = true
	game_manager.player_has_gun_in_hand = false
	player.picked_up_gun.connect(_on_gun_picked_up)

func _on_gun_picked_up():
	Transitioned.emit(self, "Armed")

func physics_process(_delta):
	if Input.is_action_just_pressed("switch item") and player.has_gun:
		Transitioned.emit(self, "Armed")
