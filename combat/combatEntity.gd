extends KinematicBody2D

export (NodePath) var target
onready var timer: Timer = $timer

var velocity: Vector2
var knockback: Vector2
var enemy: KinematicBody2D
var enemies_colliding: bool = false

func _ready() -> void:
	enemy = get_node(target)


func _physics_process(delta: float) -> void:
	_calculate_knockback(delta)
	_move_to_target(delta)


func _move_to_target(delta: float)  -> void:
	var direction: Vector2 = (enemy.global_position - global_position).normalized()
	
	velocity = velocity.move_toward(
		direction * (Constants.MAX_SPEED / 3.0), 
		delta * Constants.ACCELERATION
	)
	velocity = move_and_slide(velocity)


func _calculate_knockback(delta: float)  -> void:
	knockback = knockback.move_toward(
		Vector2.ZERO, 
		delta * Constants.ACCELERATION)
	
	knockback = move_and_slide(knockback)


func _add_knockback():
	knockback = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	if abs(knockback.x) < 0.1:
		knockback.x = rand_range(0.1, 1)
	velocity += knockback * Constants.KNOCKBACK_MULTIPLICATOR


func _on_area2D_area_entered(_area: Area2D) -> void:
	enemies_colliding = true
	timer.start()
	_add_knockback()


func _on_area2D_area_exited(_area: Area2D) -> void:
	enemies_colliding = false
	timer.stop()


func _on_timer_timeout():
	if enemies_colliding:
		_add_knockback()
		timer.start()
