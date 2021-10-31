extends KinematicBody2D

enum {
	WANDER,
	CHASE_PLAYER
}
var state = WANDER

func _physics_process(_delta: float) -> void:
	match state:
		WANDER:
			wander_around()
		CHASE_PLAYER:
			chase_player()


func wander_around():
	pass


func chase_player():
	pass


func _on_triggerZone_player_entered(value: bool) -> void:
	if value:
		state = CHASE_PLAYER
	else:
		state = WANDER
