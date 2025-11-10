extends StaticBody2D

@onready var point_light: PointLight2D = $PointLight

func _on_light_switch_lights_toggled() -> void:
	point_light.visible = !point_light.visible
