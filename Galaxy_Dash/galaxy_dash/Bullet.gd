extends Area2D

func _process(delta: float) -> void:
	if get_parent().get_node("GameOverUI").is_game_over == false:
		position.y -= get_parent().bullet_speed * delta


func _on_particles_finished() -> void:
	queue_free()
