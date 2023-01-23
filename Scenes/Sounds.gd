extends Node2D

onready var sound_jump : AudioStreamPlayer = $Jump
onready var sound_death : AudioStreamPlayer = $Death
onready var sound_pipe : AudioStreamPlayer = $Pipe
onready var music_player : AudioStreamPlayer = $Music

func _ready() -> void:
	_update_volume()
	
	music_player.play()

func _process(delta: float) -> void:
	_update_volume()

func _update_volume() -> void:
	music_player.volume_db = -80.0 + GameManager.music_volume * .8
	sound_jump.volume_db = -80.0 + GameManager.sound_volume * .8
	sound_death.volume_db = -80.0 + GameManager.sound_volume * .8
	sound_pipe.volume_db = -80.0 + GameManager.sound_volume * .8

func play_jump() -> void:
	sound_jump.play()

func play_death() -> void:
	sound_death.play()

func play_pipe() -> void:
	sound_pipe.play()
