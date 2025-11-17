extends State
class_name Armed

@onready var player = owner as Player
@onready var gun_light: PointLight2D = %GunLight
@onready var flash_light: PointLight2D = %FlashLight

func enter():
	player.unarmed_sprite.visible = false
	player.armed_sprite.visible = true
	gun_light.visible = true
	flash_light.visible = false
	player.gun_equipped = true

func physics_process(_delta):
	if Input.is_action_just_pressed("switch item"):
		Transitioned.emit(self, "Unarmed")
