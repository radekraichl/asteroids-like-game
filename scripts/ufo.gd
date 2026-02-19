extends CharacterBody2D

@export var can_move: bool = true
@export var speed_range: Vector2 = Vector2(90.0, 130.0)
@export var turn_speed: float = 10.0

var direction: Vector2 = Vector2.RIGHT
var speed: float
var target_direction: Vector2 = Vector2.RIGHT
var target_speed: float

var timer: Timer

func _ready() -> void:
	speed = speed_range.x
	target_speed = speed_range.x
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_ufo_tick)
	add_child(timer)
	_start_timer()

func _physics_process(delta: float) -> void:
	direction = direction.lerp(target_direction, turn_speed * delta).normalized()
	speed = lerp(speed, target_speed, turn_speed * delta)
	
	if can_move:
		velocity = direction * speed
		move_and_slide()

func _start_timer() -> void:
	timer.wait_time = randf_range(1.0, 3.0)
	timer.start()

func _on_ufo_tick() -> void:
	var random_angle: float = randf_range(45, 60)
	if randf() > 0.5:
		random_angle = -random_angle
	target_direction = direction.rotated(deg_to_rad(random_angle))
	target_speed = randf_range(speed_range.x, speed_range.y)
	_start_timer()
	
