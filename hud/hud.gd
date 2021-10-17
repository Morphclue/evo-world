extends Node

onready var clock: Control = $clock
var journal: PackedScene  = preload("res://menus/journal.tscn")
var journal_instance = null

func _process(_delta):
	_handle_input()


func _handle_input() -> void:
	if Input.is_action_just_pressed("journal"):
		
		if is_instance_valid(journal_instance):
			_close_windows()
		else:
			journal_instance = journal.instance()
			_add_window(journal_instance)
	
	if Input.is_action_just_pressed("ui_cancel"):
		_close_windows()


func _add_window(instance) -> void:
	get_tree().paused = true
	add_child(instance)


func _close_windows() -> void:
	journal_instance = null
	get_tree().paused = false
	Utils.remove_children(self, [clock])
	
