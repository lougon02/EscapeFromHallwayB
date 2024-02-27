extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var DIRECTION = Vector2.RIGHT

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

	move_and_slide()

func animate():
	# Tween to change sprite frame from 1 to 8.

	var tween = get_tree().create_tween().set_loops()
	tween.tween_property($Sprite2D, "frame", 7, 1).from(0)
