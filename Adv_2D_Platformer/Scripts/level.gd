extends Node2D


func _on_death_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		get_node("GameOver").game_over()
