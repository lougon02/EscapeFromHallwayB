extends Area2D

signal on_player_entered(player)

func _ready():
    var tween = create_tween().set_loops()
    tween.tween_property($Sprite2D, "frame", 7, 1).from(0)

func _on_body_entered(body: Node2D):
    Globals.num_freshmen -= 1
    body.queue_free()