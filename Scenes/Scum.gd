extends KinematicBody2D

class_name Scum

onready var scum_sprite : Sprite = $ScumSprite

var vel : float = 0

func _ready() -> void:
	GameManager.scum_ref = self

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and GameManager.alive and GameManager.game_started:
		vel = 300.0
		Sounds.play_jump()
	rotation_degrees = clamp(vel / -6, -70, 70)
	
	scum_sprite.texture = GameManager.player_skins[GameManager.selected_skin].downwards_sprite if vel < 0 else GameManager.player_skins[GameManager.selected_skin].upwards_sprite

func _physics_process(delta: float) -> void:
	if GameManager.game_started:
		move_and_slide(Vector2(200.0 if GameManager.alive else 0.0, vel * -1), Vector2.UP)
		
		if is_on_floor():
			vel = 0
		else:
			vel -= 800 * delta
		
		if not GameManager.alive:
			vel = min(vel, 0)

func _die():
	if GameManager.alive:
		GameManager.die()
		Sounds.play_death()

func _on_PipeDetector_body_entered(body: Node) -> void:
	_die()


func _on_PipePassDetector_area_entered(area: Area2D) -> void:
	GameManager.score += 1
	Sounds.play_pipe()
