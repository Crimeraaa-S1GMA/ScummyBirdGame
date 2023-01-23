extends Control

onready var score : Label = $Score

# For visual effect
var temp_score : int = 0
var display_scale : float = 1.0

func _process(delta: float) -> void:
	if temp_score != GameManager.score:
		display_scale = 2.0
	score.text = String(GameManager.score) if GameManager.game_started else ""
	score.rect_pivot_offset.x = get_viewport().get_visible_rect().size.x / 2
	score.rect_scale = Vector2(display_scale, display_scale)
	temp_score = GameManager.score
	display_scale = lerp(display_scale, 1.0, 0.1)
