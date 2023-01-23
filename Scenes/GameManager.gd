extends Node2D

var score : int = 0
var high_score : int = 0
var selected_skin : int = 0
var got_high_score_in_current_run : bool = false
var alive : bool = true
var game_started : bool = false
var music_volume : float = 100.0
var sound_volume : float = 100.0

var scum_ref : Scum = null

var player_skins : Array = [
	preload("res://PlayerSkins/Skin1.tres"),
	preload("res://PlayerSkins/Skin2.tres"),
	preload("res://PlayerSkins/Skin3.tres"),
	preload("res://PlayerSkins/Skin4.tres")
	]

func _ready() -> void:
	GameJoltAPI.set_game_credentials({
		"game_id" : "780718",
		"private_key" : "NO"
	})
	if OS.has_feature("HTML5"):
		GameJoltAPI.get_user_credentials()
	load_game()

func return_scum_x() -> float:
	if is_instance_valid(scum_ref):
		return scum_ref.position.x
	else:
		return 130.0

func restart() -> void:
	get_tree().reload_current_scene()
	score = 0
	alive = true
	game_started = false
	got_high_score_in_current_run = false

func game_start() -> void:
	if not game_started:
		game_started = true

func die() -> void:
	randomize()
	GameManager.alive = false
	if(score > high_score):
		high_score = score
		got_high_score_in_current_run = true
	if GameJoltAPI.username != "" and GameJoltAPI.user_token != "":
		GameJoltAPI.add_score({
			"username" : GameJoltAPI.username,
			"user_token" : GameJoltAPI.user_token,
			"score" : String(high_score),
			"sort" : high_score,
			"table_id" : "790476"
		})
	else:
		GameJoltAPI.add_score({
			"guest" : "Guest" + String((randi() % 900) + 100),
			"score" : String(high_score),
			"sort" : high_score,
			"table_id" : "790476"
		})
	save_game()

func save_game() -> void:
	var game_save = GameSave.new()
	
	game_save.high_score = self.high_score
	game_save.music_volume = self.music_volume
	game_save.sound_volume = self.sound_volume
	game_save.selected_skin = self.selected_skin
	
	var result = ResourceSaver.save("user://game.res", game_save)
	
	assert(result == OK)
	

func load_game():
	if ResourceLoader.exists("user://game.res"):
		var game_save = ResourceLoader.load("user://game.res")
		
		if game_save is GameSave:
			self.high_score = game_save.high_score
			self.music_volume = game_save.music_volume
			self.sound_volume = game_save.sound_volume
			self.selected_skin = game_save.selected_skin
