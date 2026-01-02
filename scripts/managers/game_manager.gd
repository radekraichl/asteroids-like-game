extends Node

var DEBUG : bool = true
var ship : Ship = null

enum GameState {
	MAIN_MENU,
	GAME,
	PAUSED
}

var game_state : GameState = GameState.GAME

signal state_changed(new_state : GameState)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func register_ship(_ship : Ship):
	if ship:
		ship.ship_destroyed.disconnect(_onship_destroyed)

	ship = _ship
	ship.ship_destroyed.connect(_onship_destroyed, CONNECT_ONE_SHOT)
	
func _process(_delta):
	# debug reset
	if Input.is_action_just_pressed("reset_game") && DEBUG:
		reset_game()

func reset_game():
	get_tree().reload_current_scene()
	StatManager.reset_score()
	StatManager.reset_health()

func set_state(new_state : GameState):
	if game_state == new_state:
		return

	game_state = new_state
	match game_state:
		GameState.MAIN_MENU:
			enter_main_menu()
		GameState.GAME:
			enter_game()
		GameState.PAUSED:
			enter_paused()

	state_changed.emit(game_state)
	
func enter_main_menu():
	pass

func enter_game():
	get_tree().paused = false

func enter_paused():
	get_tree().paused = true

func _onship_destroyed():
	ship = null
