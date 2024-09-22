extends Node
class_name idle_state

@onready var player: Node = get_parent().get_parent()
@onready var state_manager: StateManager = preload("res://Scripts/Player/States/StateManager.gd").new()

func reset_node() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.anim.play("Idle")

func _physics_process(delta: float) -> void:
	if player.current_state == "idle":
		# Use StateManager to handle movement inputs
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			player.change_state("move")

		# Use StateManager to handle jumping
		state_manager.handle_jump(player, delta)

		# Use StateManager to handle dashing
		state_manager.handle_dash(player)

		# Apply friction to gradually reduce horizontal velocity
		player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
