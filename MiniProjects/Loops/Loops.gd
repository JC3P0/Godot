extends Node2D

@export var spawn_count: int = 200
var star_scene = preload("res://Star.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_stars()

# Coroutine to spawn stars gradually
func spawn_stars() -> void:
	for i in range(spawn_count):
		var star = star_scene.instantiate()
		add_child(star)
		
		star.position.x = randi_range(-280, 280)
		star.position.y = randi_range(-150, 150)
		var star_size = randf_range(0.5, 1.0)
		star.scale.x = star_size
		star.scale.y = star_size
		
		await get_tree().create_timer(0.1).timeout
