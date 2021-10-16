extends Control

var seconds: int = 0
var minutes: int = 0
var hours: int = 0

onready var small_pointer: Node2D = $background/small
onready var big_pointer: Node2D = $background/big


func _on_time_timeout():
	_calculate_time()
	_move_pointer()


func _move_pointer():
	big_pointer.rotation_degrees = minutes * 6
	small_pointer.rotation_degrees = 30 * hours
	pass


func _calculate_time():
	minutes += 1
	
	if minutes == 60:
		minutes = 0
		hours += 1
	if hours == 12:
		hours = 0
