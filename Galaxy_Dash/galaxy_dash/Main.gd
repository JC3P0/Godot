extends Node

@export var bullet: PackedScene
@export var block: PackedScene

var time: int = 10
var bullet_speed: int = 500
var blocks_speed: int = 150
var min_blocks_health: int = 10
var max_blocks_health: int = 20
var blocks_amount_to_instantiate: int = 1
var score: int = 0

func update_time_text() -> void:
	$UI/TimeLabel.text = str(time)

func score_increased() -> void:
	score += 1
	$UI/ScoreLabel.text = "Score: " + str(score)
	
	

func _on_fire_rate_timer_timeout() -> void:
	if $GameOverUI.is_game_over == false:
		var bullet_instance: Area2D = bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.position = $Player.position

func _on_spawner_timer_timeout() -> void:
	if $GameOverUI.is_game_over == false:
		var loc: Array[int] = []
		loc.clear()
		
		for i in range(blocks_amount_to_instantiate):
			var random_spot: int = randi() % 5
			while loc.find(random_spot) != -1:
				random_spot = randi() % 5
			loc.append(random_spot)

		for i in range(blocks_amount_to_instantiate):
			var block_instance: Control = block.instantiate()
			add_child(block_instance)
			block_instance.position.x = 108 * loc[i]
			block_instance.position.y = -108

func _on_timer_timeout() -> void:
	if $GameOverUI.is_game_over == false:
		time -= 1
		update_time_text()
	if time == 0:
		$GameOverUI.game_over()


func _on_progression_timer_timeout() -> void:
	if blocks_amount_to_instantiate <= 2:
		blocks_amount_to_instantiate += 1
		bullet_speed *=2
		min_blocks_health *= 2
		max_blocks_health *= 1.5
		$FireRateTimer.wait_time /= 1.5
