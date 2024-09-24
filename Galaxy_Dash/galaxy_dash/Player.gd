extends Area2D

var min_x: int = 20
var max_x: int = 520

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click") && get_parent().get_node("GameOverUI").is_game_over == false:
		position.x = event.position.x
		position.x = clamp(position.x, min_x, max_x)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Block"):
		get_parent().get_node("GameOverUI").game_over()
		
