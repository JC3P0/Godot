extends CharacterBody2D


const SPEED = 36.0
var change_dir: bool = true
@onready var ray_wallcheck: RayCast2D = get_node("WallCheck")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (ray_wallcheck.is_colliding()):
		change_dir = !change_dir

	if change_dir:
		velocity.y = -SPEED
		ray_wallcheck.set_target_position(Vector2(-7, 0))
		get_node("AnimatedSprite2D").flip_h = false
	else:
		velocity.y = SPEED
		ray_wallcheck.set_target_position(Vector2(7, 0))
		get_node("AnimatedSprite2D").flip_h = true

	move_and_slide()

func _on_head_damage_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		death()

func _on_player_damage_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		if "dash" in body.current_state:
			death()
		else:
			Game.health -= 1
			body.get_node("hit").play()

func _on_death_finished() -> void:
	queue_free()

func death():
	get_node("death").play()
	position = Vector2(-10000,10000)
