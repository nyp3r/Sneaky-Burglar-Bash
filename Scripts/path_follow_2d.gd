extends PathFollow2D
class_name EnemyPath

var speed = 100
var walk_back = false
var paused = false

func _process(delta: float) -> void:
	if not paused:
		if not walk_back:
			progress += delta * speed
		else:
			progress -= delta * speed
		if progress_ratio == 1.0 or progress_ratio == 0.0:
			walk_back = !walk_back
	#if not walk_back:
		#progress += delta * speed
	#else:
		#progress -= delta * speed
	#if progress_ratio == 1.0 or progress_ratio == 0.0:
		#walk_back = !walk_back
