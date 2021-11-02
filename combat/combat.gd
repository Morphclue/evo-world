extends Node2D

onready var timer: Timer = $timer

func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("time_slowed", self, "_on_time_slowed"),
		"time_slowed"
	)


func _on_time_slowed():
	Engine.time_scale = 0.3
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	EventBus.emit_signal("time_resetted")
