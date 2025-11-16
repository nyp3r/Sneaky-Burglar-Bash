extends State
class_name Unarmed

@onready var player = owner as Player
@onready var gun_light: PointLight2D = %GunLight
@onready var flash_light: PointLight2D = %FlashLight

func enter():
	player.unarmed_sprite.visible = true
	player.armed_sprite.visible = false
	gun_light.visible = false
	flash_light.visible = true
	player.picked_up_gun.connect(_on_gun_picked_up)

func _on_gun_picked_up():
	Transitioned.emit(self, "Armed")

func physics_process(_delta):
	if Input.is_action_just_pressed("switch item") and player.has_gun:
		Transitioned.emit(self, "Armed")
