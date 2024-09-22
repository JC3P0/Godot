extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		get_node("AnimatedSprite2D").hide()
		Game.coins += 1
		get_node("AudioStreamPlayer2D").play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
