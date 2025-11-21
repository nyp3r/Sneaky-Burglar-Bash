extends State
class_name Armed

@onready var player = owner as Player
@onready var gun_light: PointLight2D = %GunLight
@onready var flash_light: PointLight2D = %FlashLight
@onready var game_manager: GameManager = $"../../../GameManager"

func enter():
	player.unarmed_sprite.visible = false
	player.armed_sprite.visible = true
	gun_light.visible = true
	flash_light.visible = false
	game_manager.player_has_gun_in_hand = true

func physics_process(_delta):
	if Input.is_action_just_pressed("switch item"):
		Transitioned.emit(self, "Unarmed")
