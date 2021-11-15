extends Node

onready var hud_control: Control = $hudControl
onready var clock: Control = $hudControl/clock
onready var status: Control = $hudControl/status
onready var mini_map: MarginContainer = $hudControl/miniMap

var journal_scene: PackedScene  = preload("res://ui/menus/journal.tscn")
var inventory_scene: PackedScene = preload("res://ui/menus/inventory.tscn")
var journal: Control = null
var inventory: Control = null
var current_dialogue: CanvasLayer = null

func _ready() -> void: 
	_init_signals()


func _process(_delta) -> void:
	_handle_input()


func _init_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("close_button_pressed", self, "_close_windows"),
		 "close_button_pressed"
	)

	Utils.signal_error_code(
		EventBus.connect("start_dialogue", self, "_start_dialogue"),
		 "close_button_pressed"
	)


func _start_dialogue(timeline: String) -> void:
	current_dialogue = Dialogic.start(timeline)
	
	Utils.signal_error_code(
		current_dialogue.connect("dialogic_signal", self, "_dialog_choice"),
		"timeline_end"
	)
	
	Utils.signal_error_code(
		current_dialogue.connect("timeline_end", self, "_end_dialogue"),
		"timeline_end"
	)
	
	status.visible = false
	get_tree().paused = true
	add_child(current_dialogue)


func _end_dialogue(_timeline: String) -> void:
	status.visible = true
	get_tree().paused = false
	current_dialogue = null


func _dialog_choice(argument: String) -> void:
	match argument:
		"train":
			EventBus.emit_signal("skip_time", 60)
		_:
			print(argument + " not implemented yet.")


func _handle_input() -> void:
	if current_dialogue != null:
		return
	
	if Input.is_action_just_pressed("journal"):
		if is_instance_valid(journal):
			_close_windows()
		else:
			_close_windows()
			journal = journal_scene.instance()
			_add_window(journal)
	
	if Input.is_action_just_pressed("inventory"):
		if is_instance_valid(inventory):
			_close_windows()
		else:
			_close_windows()
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
	Utils.remove_children(self, [hud_control])
	Utils.remove_children(hud_control, [clock, status, mini_map])
	
