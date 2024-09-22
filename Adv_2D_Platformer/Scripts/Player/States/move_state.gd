extends Node
class_name move_state

@onready var player: Node = get_parent().get_parent()
@onready var state_manager: StateManager = preload("res://Scripts/Player/States/StateManager.gd").new()

func reset_node() -> void:
	player.anim.play("Move")

func _physics_process(delta: float) -> void:
	if player.current_state == "move":
		state_manager.handle_movement(player, delta)
		state_manager.handle_jump(player, delta)
		state_manager.handle_dash(player)
