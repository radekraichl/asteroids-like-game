extends Node

@export var wrap_margin: float = 0

func _process(_delta: float) -> void:
	var parent_node: Node2D = get_parent() as Node2D
	if parent_node == null:
		return
	var position: Vector2 = parent_node.global_position
	
	# Horizontal wrap
	if position.x < -wrap_margin:
		position.x = Setup.screen_width + wrap_margin
	elif position.x > Setup.screen_width + wrap_margin:
		position.x = -wrap_margin
	
	# Vertical wrap
	if position.y < -wrap_margin:
		position.y = Setup.screen_height + wrap_margin
	elif position.y > Setup.screen_height + wrap_margin:
		position.y = -wrap_margin
	
	parent_node.global_position = position
