# SfxManager.gd
# Add to Project > Project Settings > Autoload as "SfxManager"

extends Node

# --- Configuration ---
const MAX_CHANNELS := 16      # Maximum number of simultaneously playing sounds
const DEFAULT_BUS := "SFX"    # Audio bus name (must exist in Audio > Buses, or use "Master")

# ---------------------------------------------
#  Public API
# ---------------------------------------------

## Plays a sound without a world position (UI clicks, global effects, etc.)
func play(stream: AudioStream, volume_db := 0.0, pitch := 1.0) -> AudioStreamPlayer:
	if stream == null:
		push_warning("SfxManager.play: stream is null, skipping playback")
		return null

	var player := _get_player()
	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch
	player.play()
	return player

## Plays a positional 2D sound at a given world position
func play_2d(stream: AudioStream, position: Vector2, volume_db := 0.0, pitch := 1.0) -> AudioStreamPlayer2D:
	if stream == null:
		push_warning("SfxManager.play_2d: stream is null, skipping playback")
		return null

	var player := _get_player_2d()
	player.stream = stream
	player.global_position = position
	player.volume_db = volume_db
	player.pitch_scale = pitch
	player.play()
	return player

## Plays a 2D sound with randomized pitch — prevents repetitive sounds from feeling robotic
func play_varied(stream: AudioStream, position: Vector2,
		pitch_min := 0.9, pitch_max := 1.1, volume_db := 0.0) -> AudioStreamPlayer2D:
	if stream == null:
		push_warning("SfxManager.play_varied: stream is null, skipping playback")
		return null

	var pitch := randf_range(pitch_min, pitch_max)
	return play_2d(stream, position, volume_db, pitch)

## Stops all currently playing sounds immediately
func stop_all() -> void:
	for p in get_children():
		if p is AudioStreamPlayer or p is AudioStreamPlayer2D:
			p.stop()

# ---------------------------------------------
#  Internal helpers
# ---------------------------------------------

## Returns a free non-positional player from the pool,
## creates a new one if the pool isn't full, or recycles the oldest one.
func _get_player() -> AudioStreamPlayer:
	# Look for an idle player already in the pool
	for p in get_children():
		if p is AudioStreamPlayer and not p.playing:
			return p

	# Pool has room — spawn a new player
	if _count_players() < MAX_CHANNELS:
		return _create_player()

	# Pool is full — steal the oldest channel to avoid sound starvation
	push_warning("SfxManager: channel pool is full (%d/%d), recycling oldest player" % [_count_players(), MAX_CHANNELS])
	return _recycle_oldest()

## Returns a free 2D player from the pool,
## creates a new one if the pool isn't full, or recycles the oldest one.
func _get_player_2d() -> AudioStreamPlayer2D:
	for p in get_children():
		if p is AudioStreamPlayer2D and not p.playing:
			return p

	if _count_players() < MAX_CHANNELS:
		return _create_player_2d()

	push_warning("SfxManager: 2D channel pool is full (%d/%d), recycling oldest player" % [_count_players(), MAX_CHANNELS])
	return _recycle_oldest_2d()

## Creates a new non-positional AudioStreamPlayer and adds it to the pool
func _create_player() -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.bus = DEFAULT_BUS
	add_child(p)
	return p

## Creates a new positional AudioStreamPlayer2D and adds it to the pool
func _create_player_2d() -> AudioStreamPlayer2D:
	var p := AudioStreamPlayer2D.new()
	p.bus = DEFAULT_BUS
	add_child(p)
	return p

## Returns the total number of players currently in the pool (both types combined)
func _count_players() -> int:
	return get_child_count()

## Stops and returns the first non-positional player found (oldest by child order)
func _recycle_oldest() -> AudioStreamPlayer:
	for p in get_children():
		if p is AudioStreamPlayer:
			p.stop()
			return p
	# Fallback: no non-positional player exists yet, create one
	push_warning("SfxManager: no AudioStreamPlayer found to recycle, creating a new one")
	return _create_player()

## Stops and returns the first 2D player found (oldest by child order)
func _recycle_oldest_2d() -> AudioStreamPlayer2D:
	for p in get_children():
		if p is AudioStreamPlayer2D:
			p.stop()
			return p
	push_warning("SfxManager: no AudioStreamPlayer2D found to recycle, creating a new one")
	return _create_player_2d()
