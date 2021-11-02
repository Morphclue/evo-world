extends Node2D

onready var timer: Timer = $timer
onready var popup: AcceptDialog = $hud/hudControl/popup
onready var key: Sprite = $pet/key
onready var ending: Label = $hud/hudControl/ending
var input_allowed: bool = false

func _ready() -> void:
	_connect_signals()


func _process(_delta: float) -> void:
	if !input_allowed:
		return
	_handle_input()


func _handle_input():
	if Input.is_action_pressed("confirm"):
		input_allowed = false
		EventBus.emit_signal("combat_bonus")


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("time_slowed", self, "_on_time_slowed"),
		"time_slowed"
	)
	
	Utils.signal_error_code(
		EventBus.connect("entity_died", self, "_on_entity_died"),
		"entity_died"
	)


func _on_entity_died(entity: KinematicBody2D) -> void:
	if entity.is_player_pet:
		popup.popup()
	Engine.time_scale = 1
	ending.visible = true
	get_tree().paused = true


func _on_time_slowed() -> void:
	key.visible = true
	input_allowed = true
	Engine.time_scale = 0.3
	timer.start()


func _on_timer_timeout():
	key.visible = false
	input_allowed = false
	Engine.time_scale = 1
	EventBus.emit_signal("time_resetted")
