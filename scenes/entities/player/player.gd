extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var DIRECTION = Vector2.RIGHT
var mouse_in = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animate()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall():
		DIRECTION *= -1
		$Sprite2D.flip_h = not $Sprite2D.flip_h

	velocity = DIRECTION * SPEED

	if is_on_floor() and Input.is_action_pressed("Click") and mouse_in == true:
		process_powerup("jump", delta)


	move_and_slide()

func animate():
	# Tween to change sprite frame from 1 to 8.

	var tween = get_tree().create_tween().set_loops()
	tween.tween_property($Sprite2D, "frame", 7, 1).from(0)


func process_powerup(powerup, _delta):
	if powerup == "jump":
		velocity.y = JUMP_VELOCITY
	elif powerup == "flip":
		# DIRECTION *= -1
		# $Sprite2D.flip_h = not $Sprite2D.flip_h
		pass
	elif powerup == "weight":
		# velocity.x *= 0.5
		# velocity.y += gravity * 4 * delta
		pass
	else:
		# error powerup desconhecido
		pass
		

func _on_mouse_entered():
	print("Entering")
	mouse_in = true
	process_powerup("jump", 0.0)


func _on_mouse_exited():
	mouse_in = false
