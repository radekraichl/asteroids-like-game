extends Node

const SETTINGS_FILE_PATH: String = "user://settings.cfg"

var sfx_index = AudioServer.get_bus_index("SFX")

var _sfx_enabled := true
var sfx_enabled: bool:
	get:
		return _sfx_enabled
	set(value):
		_sfx_enabled = value
		if sfx_index != -1:
			AudioServer.set_bus_mute(sfx_index, !_sfx_enabled)

func _ready():
	load_config()

func load_config():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE_PATH)
	if err != OK:
		sfx_enabled = true
		save_config()
	else:
		sfx_enabled = config.get_value("audio", "sfx_enabled", true)

func save_config():
	var config = ConfigFile.new()
	config.set_value("audio", "sfx_enabled", sfx_enabled)
	config.save(SETTINGS_FILE_PATH)
