extends Node2D
class_name HealthBonus

@export var heal_bonus: int = 60
@export var sfx: AudioStream

@onready var _particles: CPUParticles2D = $Particles

func _ready() -> void:
	_particles.one_shot = true
	_particles.emitting = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(LayerManager.Layer.SHIP):
		var ship: Ship = area.get_parent()
		ship.health.heal(heal_bonus)
		SfxManager.play_2d(sfx, position, 4)
		$Area2D.set_deferred("monitoring", false)
		$Animation.visible = false
		_particles.emitting = true
		await _particles.finished
		queue_free()
