extends Label

var timer : float = 0.0

func _process(delta):
	timer += delta
	if timer >= 1.0:
		text = "FPS: %d" % Engine.get_frames_per_second()
		timer = 0.0
