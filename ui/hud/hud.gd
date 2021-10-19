extends Node

onready var clock: Control = $clock
var journal_scene: PackedScene  = preload("res://ui/menus/journal.tscn")
var inventory_scene: PackedScene = preload("res://uI/menus/inventory.tscn")
var journal: Control = null
var inventory: Control = null

func _process(_delta):
	_handle_input()


func _handle_input() -> void:
	if Input.is_action_just_pressed("journal"):
		if is_instance_valid(journal):
			_close_windows()
		else:
			journal = journal_scene.instance()
			_add_window(journal)
	
	if Input.is_action_just_pressed("inventory"):
		if is_instance_valid(inventory):
			_close_windows()
		else:
			inventory = inventory_scene.instance()
			_add_window(inventory)
	
	if Input.is_action_just_pressed("ui_cancel"):
		_close_windows()


func _add_window(instance: Control) -> void:
	get_tree().paused = true
	add_child(instance)


func _close_windows() -> void:
	journal = null
	inventory = null
	get_tree().paused = false
	Utils.remove_children(self, [clock])
	
