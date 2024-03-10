extends Node2D


var freshman = preload("res://scenes/entities/player/player.tscn")

var spawn_count = 4  # Number of instances to spawn
var spawned_count = 0  # Tracks spawned instances

var powerup_uses = {
	"jump": 17,
	"flip": 7,
	"weight": 3
}
var powerup_is_area = false

func _ready():
	$UI.update_powerup_amounts(powerup_uses)

func _process(_delta):
	if Input.is_action_pressed("Left"):
		$Camera2D.position.x -= 8
	elif Input.is_action_pressed("Right"):
		$Camera2D.position.x += 8
	elif Input.is_action_just_pressed("ScrollUp") or Input.is_action_just_pressed("ScrollDown"):
		powerup_is_area = !powerup_is_area
		$UI.change_cursor(powerup_is_area)
	if Input.is_action_just_pressed("Click"):
		if powerup_is_area:
			powerup_area_placed($UI.selectedPowerup)

# Spawn of freshmen
func _on_spawn_timer_timeout():
	if spawned_count < spawn_count:
		var freshman_instance = freshman.instantiate()
		$Players.add_child(freshman_instance)
		freshman_instance.position = $Spawner/SpawnMarker.position
		spawned_count += 1
		# Create the signals connection
		freshman_instance.connect("used_powerup", _on_player_used_powerup)
	
func _on_exit_gate_body_exited(_body):
	Globals.freshmen_escaped += 1
	$UI.update_freshmen_escaped(Globals.freshmen_escaped)
	
func _on_entered_first_floor(body: CharacterBody2D):
	body.set_collision_mask_value(2,false)
	body.set_collision_mask_value(3,true)
	
func _on_entered_ground_floor(body: CharacterBody2D):
	body.set_collision_mask_value(3,false)
	body.set_collision_mask_value(2,true)
	
func powerup_area_placed(powerup: String):
	print("Powerup placed: ", powerup)
	var powerup_area = preload("res://scenes/powers/area_effect.tscn").instantiate()
	powerup_area.powerup = powerup
	
	if has_powerup(powerup):
		# Set powerup are position in the cursor position
		powerup_area.position = get_global_mouse_position()
		$PowerAreas.add_child(powerup_area)

		# Update powerup uses
		powerup_uses[powerup] -= 1
		$UI.update_powerup_amounts(powerup_uses)

# AUXILIAR FUNCTIONS

func has_powerup(powerup):
	return powerup_uses[powerup] > 0

func _on_player_used_powerup(freshman_instance: CharacterBody2D):
	var powerup = $UI.selectedPowerup

	if has_powerup(powerup):
		powerup_uses[powerup] -= 1
		freshman_instance.process_powerup(powerup)
		$UI.update_powerup_amounts(powerup_uses)
