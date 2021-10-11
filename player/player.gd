extends KinematicBody2D

var ACCELERATION = 500
var MAX_SPEED = 80
var velocity = Vector2.ZERO
onready var ray = $RayCast2D


func _physics_process(delta):
	_move(delta)


func _move(delta) -> void:
	var input = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	input = input.normalized()
	
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
		_look_in_direction(input)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)


func _look_in_direction(input) -> void:
	var look_direction = atan2(-input.x, input.y)
	ray.rotation = look_direction
