extends Control

@onready var sfx_button : CheckButton = %SFX
@onready var pause_menu : CanvasLayer = %PauseMenu

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	sfx_button.button_pressed = SettingsManager.sfx_enabled
	sfx_button.toggled.connect(_on_sfx_toggled)

func _on_back_button_pressed():
	pause_menu.set_screen(pause_menu.Screen.PAUSED)

func _on_sfx_toggled(button_pressed: bool):
	pause_menu.focus_sound.play()
	SettingsManager.sfx_enabled = button_pressed
	SettingsManager.save_config()
