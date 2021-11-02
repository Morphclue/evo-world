extends KinematicBody2D

export (NodePath) var target
export var is_player_pet: bool
onready var timer: Timer = $collisionTimer

var status: Dictionary = {
	health = 100,
	mana = 3,
}

var velocity: Vector2
var knockback: Vector2
var enemy: KinematicBody2D
var enemies_colliding: bool = false
var combat_bonus: bool

func _ready() -> void:
	enemy = get_node(target)
	_connect_signals()

func _physics_process(delta: float) -> void:
	_calculate_knockback(delta)
	_move_to_target(delta)
	_check_distance()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("combat_bonus", self, "_on_combat_bonus"),
		"combat_bonus"
	)

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


func _add_knockback() -> void:
	knockback = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	if abs(knockback.x) < 0.1:
		knockback.x = rand_range(0.1, 1)
	velocity += knockback * Constants.KNOCKBACK_MULTIPLICATOR


func _check_distance():
	var distance: int = int(global_position.distance_to(enemy.global_position))
	
	if is_player_pet \
		and distance == 33 \
		and Engine.time_scale == 1.0 \
		and knockback == Vector2.ZERO:
			EventBus.emit_signal("time_slowed")


func _calculate_damage() -> void:
	var damage: int = int(rand_range(3, 10))
	if combat_bonus: 
		damage *= 2
	print(damage)
	status.health -= damage
	if status.health <= 0:
		_handle_death()
		status.health = 0
	if is_player_pet:
		EventBus.emit_signal("combat_status_changed", status)


func _on_combat_bonus():
	if is_player_pet:
		return
	combat_bonus = true

func _handle_death() -> void:
	EventBus.emit_signal("entity_died", self)


func _on_area2D_area_entered(_area: Area2D) -> void:
	enemies_colliding = true
	timer.start()
	_calculate_damage()
	_add_knockback()


func _on_area2D_area_exited(_area: Area2D) -> void:
	enemies_colliding = false
	combat_bonus = false
	timer.stop()


func _on_timer_timeout() -> void:
	if enemies_colliding:
		_add_knockback()
		timer.start()
