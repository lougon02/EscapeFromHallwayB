extends Area2D

@export_enum("Jump", "Flip", "Weight") var powerup: String

func _ready():
	$Icon.texture = load("res://assets/powers/" + str(powerup.to_lower()) + ".png")
	var tween = create_tween().set_loops()
	tween.tween_property($PortalEffect, "frame", 5, 1).from(0)


func _on_body_entered(body:Node2D):
	if body.has_method("process_powerup"):
		body.process_powerup(powerup.to_lower())
		
