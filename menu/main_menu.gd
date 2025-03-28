extends Node2D

func _on_play_button_pressed() -> void:
	$MainMenuComponents/AnimationPlayer.play("start_game_transition")
	await $MainMenuComponents/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func _on_instructions_button_pressed():
	get_tree().change_scene_to_file("res://menu/instructions_menu.tscn")