extends Label

@onready var game_manager: GameManager = %GameManager

func _process(_delta: float) -> void:
	text = str("%0.2f" % game_manager.time," s")
