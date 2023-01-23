extends StaticBody2D

onready var bird : Node2D = get_tree().current_scene.get_node("Scum")

func _process(delta: float) -> void:
	if is_instance_valid(bird):
		position.x = bird.position.x
