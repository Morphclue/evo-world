extends Node

onready var clock: Control = $clock
var journal: PackedScene  = preload("res://menus/journal.tscn")
var open_journal: bool = false

func _process(_delta):
	_handle_input()


func _handle_input():
	if Input.is_action_just_pressed("journal"):
		if open_journal:
			_close_windows()
		else:
			_add_window(journal)
	
	if Input.is_action_just_pressed("ui_cancel"):
		_close_windows()


func _add_window(scene: PackedScene):
	open_journal = true
	get_tree().paused = true
	add_child(journal.instance())


func _close_windows():
	open_journal = false
	get_tree().paused = false
	Utils.remove_children(self, [clock])
	
