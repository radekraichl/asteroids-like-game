extends Label
class_name ScoreLabel

var displayed_score: float = 0
var tween: Tween = null

func _process(_delta):
	text = "Score : %d" % int(displayed_score)

func set_new_score(new_score: int):
	if new_score == 0:
		displayed_score = new_score
		return
		
	if tween:
		tween.kill()

	# New tween
	tween = create_tween()
	tween.tween_property(self, "displayed_score", new_score, 0.4)
