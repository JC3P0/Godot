extends Area3D

@export_file("*.tscn") var next_scene 

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		# Use call_deferred to change the scene safely after the physics step
		call_deferred("change_scene")

func change_scene() -> void:
	get_tree().change_scene_to_file(next_scene)
