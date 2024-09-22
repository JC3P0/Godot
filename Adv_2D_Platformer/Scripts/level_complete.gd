extends Area2D

@export var scene_path: PackedScene = preload("res://Scenes/Levels/Level_1.tscn")

func _on_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		get_tree().change_scene_to_packed(scene_path)
