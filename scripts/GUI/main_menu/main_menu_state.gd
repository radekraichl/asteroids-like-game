class_name MainMenuState
extends BaseState

@export var button_focus_sfx: AudioStream

@onready var _main_menu: Control = %MainMenuControl
@onready var _fade_panel: FadePanel = %FadePanel

# buttons
@onready var _new_game_button: Button = %NewGameButton
@onready var _exit_button: Button = %ExitButton
@onready var _buttons: Array = [_new_game_button, _exit_button]

var _ignore_next_focus: bool = false
var _using_mouse: bool = true

func _ready() -> void:
	_fade_panel.set_faded()
	_fade_panel.fade_out(1)
	_ignore_next_focus = true
	_exit_button.pressed.connect(_on_exit_button_pressed)

	for btn: Button in _buttons:
		btn.mouse_entered.connect(_on_button_mouse_entered.bind(btn))
		btn.focus_entered.connect(_on_button_focus)

func _on_button_mouse_entered(btn: Button) -> void:
	btn.grab_focus()

func _enable_mouse(enable: bool) -> void:
	var mode := Control.MOUSE_FILTER_STOP if enable else Control.MOUSE_FILTER_IGNORE
	for btn in _buttons:
		btn.mouse_filter = mode

func _on_button_focus() -> void:
	if _ignore_next_focus:
		_ignore_next_focus = false
		return

	SfxManager.play(button_focus_sfx, 0.0, 1.45)

func _on_exit_button_pressed() -> void:
	_fade_panel.fade_in()
	await _fade_panel.fade_finished
	get_tree().quit()


# ------------------------------------------------------------
# State Machine Methods
# ------------------------------------------------------------

func enter(_msg: Dictionary = {}):
	_main_menu.visible = true
	_new_game_button.grab_focus()

func exit() -> void:
	_main_menu.visible = false

func input(event: InputEvent):
	if event is InputEventMouseMotion:
		_using_mouse = true
		_enable_mouse(true)

	elif event is InputEventKey or event is InputEventJoypadButton:
		_using_mouse = false
		_enable_mouse(false)
