# space_movement.gd
extends Node2D
class_name SpaceMovement

@export var can_move: bool = true
@export var speed_range: Vector2 = Vector2(50.0, 100.0)
@export var direction: Vector2 = Vector2(1.0, 0.0)

var speed: float = 0.0

func _ready() -> void:
	speed = randf_range(speed_range.x, speed_range.y)
	if direction != Vector2.ZERO:
		direction = direction.normalized()

func _physics_process(delta: float) -> void:
	if get_parent() && can_move:
		get_parent().position += direction * speed * delta
