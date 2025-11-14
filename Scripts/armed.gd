extends State
class_name Armed

@onready var player = owner as Player

func enter():
	player.unarmed_sprite.visible = false
	player.armed_sprite.visible = true
