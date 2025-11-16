extends Label

func _ready() -> void:
	var file = FileAccess.open("res://save_file.txt", FileAccess.READ)
	text = str("%0.2f" % file.get_float(), "s")
