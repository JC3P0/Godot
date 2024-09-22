extends Node
class_name fall_state

@onready var player: Node = get_parent().get_parent()
@onready var state_manager: StateManager = preload("res://Scripts/Player/States/StateManager.gd").new()

func reset_node() -> void:
	pass  # No specific reset logic needed for falling

func _physics_process(delta: float) -> void:
	if player.current_state == "fall":
		# Use StateManager to handle movement inputs
		state_manager.handle_movement(player, delta)

		# Use StateManager to handle jumping
		state_manager.handle_jump(player, delta)

		# Check if player lands on the floor
		if player.is_on_floor():
			player.change_state("idle")
