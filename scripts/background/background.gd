extends Node2D

@export var far_factor  := 0.1
@export var mid_factor  := 0.2
@export var near_factor := 0.3

@onready var far  := $Parallax2DFar
@onready var mid  := $Parallax2DMid
@onready var near  := $Parallax2DNear

@onready var _ship: CharacterBody2D = %Ship

func _process(delta):
	if _ship == null:
		return
	var velocity: Vector2 = _ship.velocity
	if velocity.is_zero_approx():
		return
	var movement : Vector2 = velocity * delta
	far.scroll_offset -= movement * far_factor
	mid.scroll_offset -= movement * mid_factor
	near.scroll_offset -= movement * near_factor
