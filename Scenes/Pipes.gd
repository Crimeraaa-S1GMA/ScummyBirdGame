extends Node2D


func _process(delta: float) -> void:
	if position.x < GameManager.return_scum_x() - 1600:
		queue_free()
