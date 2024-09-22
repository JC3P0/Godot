extends Node
class_name jump_state

@onready var player: Node = get_parent().get_parent()
@onready var state_manager: StateManager = preload("res://Scripts/Player/States/StateManager.gd").new()

func reset_node() -> void:
	player.get_node("jump").play()

func _physics_process(delta: float) -> void:
	if player.current_state == "jump":
		state_manager.handle_movement(player, delta)
		state_manager.handle_jump(player, delta)
		if player.velocity.y > 0:
			player.change_state("fall")
