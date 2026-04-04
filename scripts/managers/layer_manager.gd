extends Node

enum Layer {
	SHIP = 1,
	ASTEROID = 2,
	PROJECTILE = 3,
	UFO = 4
}

func is_in_layer(body, layer: int) -> bool:
	return body.get_collision_layer() & (1 << (layer - 1))

func get_layer_mask(layer: int) -> int:
	return 1 << (layer - 1)
