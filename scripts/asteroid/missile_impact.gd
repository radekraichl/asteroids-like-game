extends Node

@onready var animation : AnimatedSprite2D = $Impact

func _ready():
	animation.play("impact")
	await animation.animation_finished
	queue_free()
