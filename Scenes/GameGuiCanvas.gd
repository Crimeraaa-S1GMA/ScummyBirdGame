extends CanvasLayer

onready var main_menu : Control = $MainMenu
onready var death_screen : Control = $DeathScreen

onready var high_score_label : Label = $MainMenu/HighScoreLabel

onready var music_volume_slider : HSlider = $MainMenu/MusicVolumeSlider
onready var sound_volume_slider : HSlider = $MainMenu/SoundVolumeSlider

func _process(delta: float) -> void:
	main_menu.visible = not GameManager.game_started
	death_screen.visible = not GameManager.alive
	
	high_score_label.text = "High Score: {0}".format({"0" : GameManager.high_score})
	
	music_volume_slider.value = GameManager.music_volume
	sound_volume_slider.value = GameManager.sound_volume

