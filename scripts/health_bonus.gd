extends Node2D
class_name HealthBonus

@export var heal_bonus: int = 70
@export var sfx: AudioStream

@onready var _particles: CPUParticles2D = $Particles
@onready var _health: Health = $Health
@onready var _explosion_anim: AnimatedSprite2D = $ExplosionAnim
@onready var _collision: CollisionShape2D = $CollisionArea/CollisionShape
@onready var _sprite: AnimatedSprite2D = $BonusSpriteAnim

func hit(hit_info: HitInfo) -> void:
	_health.take_damage(hit_info.damage)

func disable() -> void:
	_collision.disabled = true
	_sprite.visible = false

func _ready() -> void:
	_particles.one_shot = true
	_particles.emitting = false

	_health.died.connect(_on_died)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(LayerManager.Layer.SHIP):
		disable()
		var ship: Ship = area.get_parent()
		ship.health.heal(heal_bonus)
		SfxManager.play_2d(sfx, position, 3)
		_particles.emitting = true
		await _particles.finished
		queue_free()

func _on_died() -> void:
	disable()
	_explosion_anim.play()
	_particles.emitting = true
	await _explosion_anim.animation_finished
	queue_free()
