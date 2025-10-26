extends PathFollow2D

var speed = 100
var walk_back = false

func _process(delta: float) -> void:
	if not walk_back:
		progress += delta * speed
	else:
		progress -= delta * speed
	if progress_ratio == 1.0 or progress_ratio == 0.0:
		walk_back = !walk_back
