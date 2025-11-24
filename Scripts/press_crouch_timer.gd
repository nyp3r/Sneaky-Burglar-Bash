extends Timer

@onready var press_crouch_animation: AnimatedSprite2D = $"../CanvasLayer/PressCrouchAnimation"

func _ready() -> void:
	var scores_file = FileAccess.open("user://scores.txt", FileAccess.READ)
	if scores_file == null:
		press_crouch_animation.visible = true
		press_crouch_animation.play()
		start()

func _on_timeout() -> void:
	press_crouch_animation.stop()
	press_crouch_animation.visible = false
