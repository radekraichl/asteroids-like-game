extends Node

@onready var animation : AnimatedSprite2D = $Impact

var color: Color = Color("eba54cff")

func _ready():
	animation.modulate = color
	animation.play("impact")
	await animation.animation_finished
	queue_free()
