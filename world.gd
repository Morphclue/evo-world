extends Node2D

const combat_scene: PackedScene = preload("res://combat/combat.tscn")

func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Utils.signal_error_code(
		EventBus.connect("combat_started", self, "_on_combat_started"),
		"combat_started"
	)


func _on_combat_started(enemy: KinematicBody2D) -> void:
	var scene: PackedScene = PackedScene.new()
	var _error = scene.pack(get_tree().get_current_scene())
	Utils.save_world(scene, enemy)
	
	call_deferred("_remove_enemy", enemy)
	Utils.switch_scene(self, combat_scene)


func _remove_enemy(enemy):
	enemy.get_parent().remove_child(enemy)
