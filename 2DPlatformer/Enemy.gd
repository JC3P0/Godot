extends Area2D

@export var move_speed: float = 30.0
@export var move_dir: Vector2

var start_pos: Vector2
var target_pos: Vector2

func _ready() -> void:
	start_pos = global_position
	target_pos = start_pos + move_dir

func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	# Correct logic to switch between positions
	if global_position.distance_to(target_pos) < 1.0:
		if target_pos == start_pos + move_dir:
			target_pos = start_pos
		else:
			target_pos = start_pos + move_dir


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.game_over()
