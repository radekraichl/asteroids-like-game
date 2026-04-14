extends CanvasLayer

@onready var score_label : ScoreLabel = %ScoreLabel
@onready var hp_bar : HealthBar = %HealthBar

func _ready():
	StatManager.score_changed.connect(_on_score_changed)
	StatManager.health_changed.connect(_on_health_changed)

func _on_score_changed(new_score : int):
	score_label.set_new_score(new_score)

func _on_health_changed(new_health : int):
	hp_bar.set_hp(new_health)
