extends KinematicBody2D

export (NodePath) var target

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_move_to_target(delta)
	_calculate_knockback(delta)


func _move_to_target(delta: float)  -> void:
	pass


func _calculate_knockback(delta: float)  -> void:
	pass
