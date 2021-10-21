extends KinematicBody2D

onready var player: Node2D = get_node("../player")
var status: Dictionary = {
	hunger = 100,
	toilet = 100,
	mood = 100,
	respect = 100
}

func _ready() -> void:
	_emit_change()


func _physics_process(delta: float) -> void:
	position = position.linear_interpolate(player.position, delta * Constants.FOLLOW_SPEED)


func _emit_change() -> void:
	EventBus.emit_signal("status_changed", status)


func _on_timer_timeout() -> void:
	_decrease_values()
	_emit_change()


func _decrease_values() -> void:
	status.hunger -= 2
	status.toilet -= 1
	status.mood -= 1
	status.respect -= 1
