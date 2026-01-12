extends Node2D

@export var speed_x: float = 65.0
@export var speed_y: float = 65.0
@export var amplitude: float = 4.0
@export var frequency: float = 0.8

var base_pos: Vector2
var t: float = 0.0

func _ready() -> void:
	base_pos = position

func _process(delta: float) -> void:
	t += delta

	# základní lineární pohyb
	base_pos.x += speed_x * delta
	#base_pos.y += speed_y * delta

	# finální pozice = základ + kmitání
	position.x = base_pos.x
	position.y = base_pos.y
	position.y = base_pos.y + sin(t * TAU * frequency) * amplitude
