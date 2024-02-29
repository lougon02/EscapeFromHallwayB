extends Node2D

var freshman = preload("res://scenes/entities/player/player.tscn")

var spawn_count = 4  # Number of instances to spawn
var spawned_count = 0  # Tracks spawned instances

# Spawn of freshmen
func _on_spawn_timer_timeout():
	
	if spawned_count < spawn_count:
		var freshman_instance = freshman.instantiate()
		add_child(freshman_instance)
		freshman_instance.position = $SpawnMarker.position
		spawned_count += 1
		# Create the signals connection
		freshman_instance.connect("has_jumped", _on_player_has_jumped)
		freshman_instance.connect("has_flip", _on_player_has_flip)
		freshman_instance.connect("has_weight", _on_player_has_weight)

# Signal capture and update UI
func _on_player_has_jumped():
	print("Processing jump...")
	$UI.update_jump_button()

func _on_player_has_flip():
	print("Processing flip...")
	$UI.update_flip_button()
	
func _on_player_has_weight():
	print("Processing weight...")
	$UI.update_weight_button()
