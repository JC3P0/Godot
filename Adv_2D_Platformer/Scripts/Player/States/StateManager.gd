# StateManager.gd
extends Node
class_name StateManager  # Register the script globally

# Player variables
var max_speed: float = 1000.0
var ground_acceleration: float = 400.0
var air_acceleration: float = 600.0
var jump_height: int = 9000
var max_jumps: int = 3
var ground_weight: float = 0.42  # Weight for ground movement
var air_weight: float = 0.3      # Lower weight for in-air movement for quicker response
var friction: float = 0.2        # Friction when stopping on the ground

# Method to handle horizontal movement
func handle_movement(player, delta: float) -> void:
	# Determine the current acceleration and weight based on the player's state
	var current_acceleration = ground_acceleration if player.is_on_floor() else air_acceleration
	var current_weight = ground_weight if player.is_on_floor() else air_weight

	# Check for right movement input
	if Input.is_action_pressed("move_right"):
		# If moving left and switching to right mid-air, stop velocity first
		if player.velocity.x < 0 and not player.is_on_floor():
			player.velocity.x = lerp(player.velocity.x, 0.0, 0.5)  # Quick stop
		# Calculate the target velocity to the right
		var target_vel: float = min(player.velocity.x + current_acceleration * delta, max_speed)
		player.velocity.x = lerp(player.velocity.x, target_vel, current_weight)
	
	# Check for left movement input
	elif Input.is_action_pressed("move_left"):
		# If moving right and switching to left mid-air, stop velocity first
		if player.velocity.x > 0 and not player.is_on_floor():
			player.velocity.x = lerp(player.velocity.x, 0.0, 0.5)  # Quick stop
		# Calculate the target velocity to the left
		var target_vel: float = max(player.velocity.x - current_acceleration * delta, -max_speed)
		player.velocity.x = lerp(player.velocity.x, target_vel, current_weight)
	
	else:
		# Apply friction or stopping logic when no input is detected
		if player.is_on_floor():
			player.velocity.x = lerp(player.velocity.x, 0.0, friction)
		else:
			# When airborne, do not accelerate further and gradually reduce speed
			player.velocity.x = lerp(player.velocity.x, 0.0, 0.1)

	# If the player is on the ground and not moving, change to idle state
	if player.is_on_floor() and abs(player.velocity.x) < 1:
		player.change_state("idle")

# Method to handle jumping
func handle_jump(player, delta: float) -> void:
	if Input.is_action_just_pressed("jump") and (player.jump_count < max_jumps):
		player.jump_count += 1
		player.velocity.y = -jump_height * delta
		player.change_state("jump")

# Method to handle dashing
func handle_dash(player) -> void:
	if Input.is_action_just_pressed("dash") and player.can_dash and player.is_on_floor():
		player.change_state("dash")
