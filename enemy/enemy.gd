extends KinematicBody2D

export (NodePath) var player
var start_position: Vector2
var target_position: Vector2
var velocity: Vector2
var state = WANDER

enum {
	STOP,
	WANDER,
	CHASE_PLAYER,
	MOVE_BACK,
}

const minimap_icon = Constants.ENEMY_ICON
onready var timer: Timer = $timer

func _ready():
	randomize()
	start_position = global_position
	target_position = global_position
	velocity = Vector2.ZERO
	_change_target()


func _physics_process(delta: float) -> void:
	match state:
		STOP:
			_stop_movement(delta)
		WANDER:
			_move_to_vector(target_position, delta)
			if global_position.distance_to(target_position) <= 1:
				state = STOP
		CHASE_PLAYER:
			_chase_player(delta)
		MOVE_BACK:
			_move_back(delta)
	velocity = move_and_slide(velocity)


func _change_target() -> void:
	var change: Vector2 = Vector2(
		rand_range(-Constants.MAX_WANDER_RANGE, Constants.MAX_WANDER_RANGE),
		rand_range(-Constants.MAX_WANDER_RANGE, Constants.MAX_WANDER_RANGE)
	)
	
	target_position = start_position + change


func _move_to_vector(vector: Vector2, delta: float) -> void:
	var direction: Vector2 = (vector - global_position).normalized()
	
	velocity = velocity.move_toward(
		direction * (Constants.MAX_SPEED / 2.0), 
		delta * Constants.ACCELERATION
	)


func _stop_movement(delta: float) -> void:
	velocity = velocity.move_toward(
		Vector2.ZERO * Constants.MAX_SPEED,
		Constants.ACCELERATION * delta
	)


func _chase_player(delta: float) -> void:
	if !player:
		return
	_move_to_vector(get_node(player).position, delta)


func _move_back(delta: float) -> void:
	_move_to_vector(start_position, delta)
	if global_position.distance_to(start_position) <= 1:
		state = WANDER


func _on_triggerZone_player_entered(value: bool) -> void:
	if value:
		state = CHASE_PLAYER
	else:
		state = MOVE_BACK


func _on_timer_timeout():
	match state:
		STOP:
			_change_target()
			state = WANDER
		WANDER:
			state = STOP
		CHASE_PLAYER:
			return
		MOVE_BACK:
			return
		_:
			state = MOVE_BACK
