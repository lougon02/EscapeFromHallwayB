extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -450.0
var DIRECTION = Vector2.RIGHT
var mouse_in = false
var gravity_modifier = 1.0
var speed_modifier = 1.0

# Signals
signal has_jumped
signal has_flip
signal has_weight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animate()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * gravity_modifier * delta

	if is_on_wall():
		DIRECTION.x *= -1
		$Sprite2D.flip_h = not $Sprite2D.flip_h

	if is_on_floor():
		if Input.is_action_just_pressed("Click") and mouse_in == true:
			if Globals.is_jump:
				process_powerup("jump")
			elif Globals.is_flip:
				process_powerup("flip")
			elif Globals.is_weight:
				process_powerup("weight")
			else:
				pass


	velocity.x = DIRECTION.x * SPEED * speed_modifier

	move_and_slide()

func animate():
	# Tween to change sprite frame from 1 to 8.
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property($Sprite2D, "frame", 7, 1).from(0)

func process_powerup(powerup):
	if powerup == "jump":
		velocity.y = JUMP_VELOCITY
		has_jumped.emit()
		
	elif powerup == "flip":
		DIRECTION.x *= -1
		$Sprite2D.flip_h = not $Sprite2D.flip_h
		has_flip.emit()
		
	elif powerup == "weight":
		speed_modifier = 0.5
		gravity_modifier = 5.0
		has_weight.emit()
	else:
		# error powerup desconhecido
		pass
		
func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
