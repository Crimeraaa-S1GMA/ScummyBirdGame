extends Node2D

onready var pipe : PackedScene = preload("res://Scenes/Pipes.tscn")

var pipe_x : int = 730

func _ready() -> void:
	randomize()
	for i in range(5):
		_spawn_pipe()

func _on_PipeSpawnTimer_timeout() -> void:
	_spawn_pipe()


func _spawn_pipe() -> void:
	if is_instance_valid(pipe):
		var pipe_spawn = pipe.instance()
		pipe_spawn.position = Vector2(pipe_x, rand_range(202, 382))
		add_child(pipe_spawn)
		
		pipe_x += rand_range(200, 320)
