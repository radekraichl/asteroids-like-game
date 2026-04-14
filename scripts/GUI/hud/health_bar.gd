extends TextureProgressBar
class_name HealthBar

@export var smooth_speed := 100.0

# thresholds
@export var high_threshold := 0.66
@export var mid_threshold  := 0.33

# colors
@export var high_color : Color = Color.GREEN
@export var mid_color  : Color = Color.YELLOW
@export var low_color  : Color = Color.RED

var target_hp := 0.0

func _ready() -> void:
	step = 0.0
	target_hp = value
	_update_color()

func set_hp(current: int) -> void:
	target_hp = clamp(current, min_value, max_value)

func _process(delta: float) -> void:
	value = move_toward(value, target_hp, smooth_speed * delta)
	_update_color()

func _update_color() -> void:
	if max_value <= 0:
		return

	var _ratio := value / max_value
	if _ratio > high_threshold:
		tint_progress = high_color
	elif _ratio > mid_threshold:
		tint_progress = mid_color
	else:
		tint_progress = low_color
