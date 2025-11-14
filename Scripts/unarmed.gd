extends State
class_name Unarmed

@onready var player = owner as Player

func enter():
	player.unarmed_sprite.visible = true
	player.armed_sprite.visible = false
	player.picked_up_gun.connect(_on_gun_picked_up)

func _on_gun_picked_up():
	Transitioned.emit(self, "Armed")
