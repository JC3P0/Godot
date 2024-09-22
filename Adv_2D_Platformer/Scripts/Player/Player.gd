extends CharacterBody2D

@onready var anim: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var state_manager: StateManager = preload("res://Scripts/Player/States/StateManager.gd").new()

var direction: int = 0
var friction: float = 0.22

###States###
var current_state: String = ""
var can_dash: bool = true
var jump_count: int = 0

func _ready() -> void:
	change_state("idle")

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		# Correctly use state_manager's properties for acceleration and max_speed
		var target_vel: float = min(velocity.y + state_manager.ground_acceleration * delta, state_manager.max_speed)
		velocity.y = lerp(velocity.y, target_vel, 0.618)

	# Handle input for direction
	direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		anim.flip_h = false
	elif direction > 0:
		anim.flip_h = true
	move_and_slide()

func change_state(new_state_name: String) -> void:
	current_state = new_state_name
	for i in get_node("States").get_child_count():
		if new_state_name in get_node("States").get_child(i).name:
			get_node("States").get_child(i).reset_node()
