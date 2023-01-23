extends Control

onready var skin_name : Label = $SkinName
onready var skin_sprite : TextureRect = $SkinSprite
onready var skin_unlock_criteria : Label = $SkinUnlockCriteria

onready var prev_button : Button = $PrevSkin
onready var next_button : Button = $NextSkin

var skin_index : int = 0

var is_downwards_frame_prev : bool = false

func _ready() -> void:
	skin_index = GameManager.selected_skin

func _process(delta: float) -> void:
	skin_name.text = GameManager.player_skins[skin_index].skin_name
	skin_sprite.texture = GameManager.player_skins[skin_index].downwards_sprite if is_downwards_frame_prev else GameManager.player_skins[skin_index].upwards_sprite
	skin_unlock_criteria.text = "Reach a high score of {s} to unlock".format({"s" : GameManager.player_skins[skin_index].min_high_score}) if GameManager.player_skins[skin_index].min_high_score > GameManager.high_score else "\"" + GameManager.player_skins[skin_index].skin_desc + "\""
	
	if GameManager.player_skins[skin_index].min_high_score <= GameManager.high_score and GameManager.selected_skin != skin_index:
		GameManager.selected_skin = skin_index
		GameManager.save_game()
	
	prev_button.visible = skin_index > 0
	next_button.visible = skin_index < GameManager.player_skins.size() - 1

func skin_index_set(incr : int):
	skin_index = clamp(skin_index + incr, 0, GameManager.player_skins.size() - 1)

func _on_Play_pressed() -> void:
	GameManager.game_start()


func _on_MusicVolumeSlider_value_changed(value: float) -> void:
	GameManager.music_volume = value
	GameManager.save_game()


func _on_SoundVolumeSlider_value_changed(value: float) -> void:
	GameManager.sound_volume = value
	GameManager.save_game()


func _on_PrevSkin_pressed() -> void:
	skin_index_set(-1)


func _on_NextSkin_pressed() -> void:
	skin_index_set(1)


func _on_Timer_timeout() -> void:
	is_downwards_frame_prev = not is_downwards_frame_prev
