extends Node2D

@export var speed_x: float = 25.0
@export var speed_y: float = 15.0

func _process(delta: float) -> void:
	position.x += speed_x * delta
	position.y += speed_y * delta
