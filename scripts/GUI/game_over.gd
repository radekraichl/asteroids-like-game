extends CanvasLayer

func _ready():
	GameManager.game_over.connect(_on_game_over)
	
func _on_game_over():
	await get_tree().create_timer(1.5).timeout
	show()

func _input(event: InputEvent) -> void:
	if visible:
		if GameManager.game_state == GameManager.GameState.GAME_OVER:
			if ((event is InputEventKey or event is InputEventJoypadButton) 
				and event.pressed 
				and not event.is_echo()):
				GameManager.reset_game()
