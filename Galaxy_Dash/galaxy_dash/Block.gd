extends Control

@export var colors: Array[Color]
var health: int

func _ready():
	$Background.color = colors[randi() % colors.size()]
	$Particles.color = $Background.color
	health = randi_range(get_parent().min_blocks_health, get_parent().max_blocks_health)
	$HealthLabel.text = str(health)

func _process(delta):
	if get_parent().get_node("GameOverUI").is_game_over == false:
		position.y += get_parent().blocks_speed * delta
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		health -= 1
		$HealthLabel.text = str(health)
		#remove/explode bullet
		area.get_node("CollisionShape2D").set_deferred("disabled", true)
		area.get_node("Sprite2D").hide()
		area.get_node("Particles").emitting = true
		area.get_node("Particles").position = Vector2(area.position.x, area.position.y - 12)
		get_parent().score_increased()

	if health <= 0:
		$Particles.emitting = true
		$Particles.position = position + Vector2(54, 54)
		$Background.hide()
		$HealthLabel.hide()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		get_parent().time = 11
		get_parent().update_time_text


func _on_particles_finished() -> void:
	#remove block
	queue_free()
