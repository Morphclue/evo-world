extends Node

onready var clock = $clock
var journal = preload("res://menus/journal.tscn")

func _process(_delta):
	_handle_input()


func _handle_input():
	if Input.is_action_just_pressed("journal"):
		get_tree().paused = true
		add_child(journal.instance())
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		for n in get_children():
			if n == clock: 
				continue
			remove_child(n)
			n.queue_free()
