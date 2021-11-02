extends KinematicBody2D

export (NodePath) var target
onready var collider: CollisionShape2D = $collider

var velocity: Vector2
var knockback: Vector2
var enemy: KinematicBody2D

func _ready() -> void:
	enemy = get_node(target)


func _physics_process(delta: float) -> void:
	_move_to_target(delta)
	_calculate_knockback(delta)
	velocity = move_and_slide(velocity)


func _move_to_target(delta: float)  -> void:
	var direction: Vector2 = (enemy.position - position).normalized()
	
	velocity = velocity.move_toward(
		direction * (Constants.MAX_SPEED), 
		delta * Constants.ACCELERATION
	)


func _calculate_knockback(_delta: float)  -> void:
	pass
