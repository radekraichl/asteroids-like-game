class_name Projectile
extends CharacterBody2D

@export var speed: float = 500.0
@export var color: Color = Color("ffffff")
@onready var sprite: Sprite2D = $Sprite
@onready var shader: ShaderMaterial = $Sprite.material as ShaderMaterial
var hit_info: HitInfo = HitInfo.new()

func _ready() -> void:
	$VisibleOnScreenNotifier.visible = true
	sprite.modulate = color
	shader.set_shader_parameter("glow_color", color)

func _physics_process(delta):
	velocity = Vector2.UP.rotated(rotation) * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		hit_info.angle = collision.get_angle()
		hit_info.position = collision.get_position()
		hit_info.velocity = velocity
		hit_info.source = self

		var hit = collision.get_collider()
		if hit.has_method("hit"):
			hit.hit(hit_info)
		queue_free()

func _on_screen_exited():
	queue_free()
