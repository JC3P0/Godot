extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	get_tree().paused = false


func _on_retry_pressed() -> void:
	Game.coins = 0
	Game.health = Game.max_health
	self.hide()
	get_node("gameover").play()
	get_tree().reload_current_scene()
	
func game_over() -> void:
	self.show()
	get_tree().paused = true
