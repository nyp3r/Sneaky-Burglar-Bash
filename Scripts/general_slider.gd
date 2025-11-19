extends HSlider



func _on_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(0, value)
