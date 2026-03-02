extends AnimatedSprite2D

@export var shield_color: Color = Color("0f73d2ff")
@export var impact_color: Color = Color("1c8ffdff")
@export var particles_color: Color = Color("41a2ffff")
@onready var collision_shape: CollisionShape2D = %CollisionShape
var missile_impact: PackedScene = preload("res://scenes/projectile/projectile_impact.tscn")

func _ready() -> void:
	modulate = shield_color
	set_active(true)

func set_active(active: bool) -> void:
	collision_shape.disabled = not active

func hit(hit_info: HitInfo):
	# impact
	var impact := missile_impact.instantiate()
	impact.color = impact_color
	impact.particles_color = particles_color

	impact.global_position = hit_info.position
	get_tree().current_scene.add_child(impact)
