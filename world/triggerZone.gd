extends Area2D

var player_inside_zone: bool = false

func _on_triggerZone_body_entered(body):
	player_inside_zone = true


func _on_triggerZone_body_exited(body):
	player_inside_zone = false
