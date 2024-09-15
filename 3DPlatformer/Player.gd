extends CharacterBody3D

var move_speed : float = 4.0
var jump_force : float = 8.0
var gravity : float = 20.0

var facing_angle : float

var score : int

@onready var model : MeshInstance3D = get_node("Model")
@onready var score_text : Label = get_node("ScoreText")

func _physics_process(delta: float) -> void:
	# Apply gravity 
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Jump logic
	if Input.is_action_pressed("move_jump") and is_on_floor():
		velocity.y = jump_force
		
	# Get keyboard input
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# Calculate move direction
	var dir = Vector3(input.x, 0, input.y)
	
	# Assign direction to velocity
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	# Apply velocity
	move_and_slide()
	
	# Set facing direction while moving
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()
	
	# Rotate model to facing direction
	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.618)

	# End game when player is below -6 on the y axis
	if global_position.y < -6:
		game_over()
	
func game_over():
	call_deferred("reload_scene")  # Defer the reload to avoid physics callback issues

func reload_scene():
	get_tree().reload_current_scene()
	
func add_score(amount):
	score += amount
	score_text.text = str("Coins: ", score)
