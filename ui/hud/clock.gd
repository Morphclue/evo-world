extends Control

var seconds: int = 0
var minutes: int = 0
var hours: int = 0

onready var small_pointer: Node2D = $background/small
onready var big_pointer: Node2D = $background/big

func _ready() -> void:
	_init_signals()


func _init_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("skip_time", self, "_skip_time"),
		"skip_time"
	)


func _skip_time(_minutes: int) -> void:
	for _i in range(_minutes):
		_calculate_time()


func _on_time_timeout() -> void:
	_calculate_time()
	_move_pointer()


func _move_pointer() -> void:
	big_pointer.rotation_degrees = minutes * 6
	small_pointer.rotation_degrees = 30 * hours


func _calculate_time() -> void:
	minutes += 1
	
	if minutes == 60:
		minutes = 0
		hours += 1
	if hours == 12:
		hours = 0
