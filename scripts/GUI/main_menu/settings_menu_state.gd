class_name SettingsMenuState
extends BaseState

func enter(_msg: Dictionary = {}) -> void:
	for key in _msg:
		print("%s: %s" % [key, _msg[key]])
