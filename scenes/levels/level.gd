extends Node2D

var freshman = preload("res://scenes/entities/player/player.tscn")

var spawn_count = 4  # Number of instances to spawn
var spawned_count = 0  # Tracks spawned instances

func _on_spawn_timer_timeout():
	
	if spawned_count < spawn_count:
		var freshman_instance = freshman.instantiate()
		add_child(freshman_instance)
		freshman_instance.position = $SpawnMarker.position
		spawned_count += 1
