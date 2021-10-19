extends KinematicBody2D

onready var player: Node2D = get_node("../player")

func _physics_process(delta):
	position = position.linear_interpolate(player.position, delta * Constants.FOLLOW_SPEED)
