extends Node2D

const combat_scene: PackedScene = preload("res://combat/combat.tscn")

func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("combat_started", self, "_on_combat_started"),
		"combat_started"
	)


func _on_combat_started(_enemy: KinematicBody2D) -> void:
	Utils.switch_scene(self, combat_scene)
