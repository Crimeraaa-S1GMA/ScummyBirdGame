extends Control

onready var high_score_notif : Label = $NewHighScore

func _process(delta: float) -> void:
	high_score_notif.visible = GameManager.got_high_score_in_current_run


func _on_Restart_pressed() -> void:
	if not GameManager.alive:
		GameManager.restart()
