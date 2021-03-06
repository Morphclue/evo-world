extends Area2D

var player_inside_zone: bool = false setget _set_player_inside_zone
signal player_entered

func _on_triggerZone_body_entered(_body: PhysicsBody2D) -> void:
	self.player_inside_zone = true


func _on_triggerZone_body_exited(_body: PhysicsBody2D) -> void:
	self.player_inside_zone = false


func _set_player_inside_zone(value: bool) -> void:
	player_inside_zone = value
	emit_signal("player_entered", value)
