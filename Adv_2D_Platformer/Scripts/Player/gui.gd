extends CanvasLayer

@onready var coin_label: Label = get_node("Coins")
@onready var heart_container: HBoxContainer = get_node("heartContainer")
@onready var heart_scene: PackedScene = preload("res://Scenes/Player/heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(Game.health):
		var heart_temp: Node = heart_scene.instantiate()
		heart_container.add_child(heart_temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_label.text = "Coins: " + str(Game.coins)

	# Check if the player's health is greater than 0
	if Game.health > 0:
		# If there are more hearts displayed than the current health, remove one
		if heart_container.get_child_count() > Game.health:
			heart_container.get_child(heart_container.get_child_count() - 1).queue_free()
	else:
		# If health is 0 or less, trigger game over
		get_node("../GameOver").game_over()
