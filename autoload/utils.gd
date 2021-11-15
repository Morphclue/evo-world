extends Node

var world_scene: PackedScene
var enemy: KinematicBody2D

func switch_scene(parent: Node, scene: PackedScene) -> void:
	call_deferred("_switch_scene", parent, scene)


func _switch_scene(parent: Node, scene: PackedScene) -> void:
	get_parent().add_child(scene.instance())
	parent.queue_free()


func remove_children(parent: Node, ignore = []) -> void:
	for n in parent.get_children():
		if n in ignore:
			continue
		parent.remove_child(n)
		n.queue_free()


func signal_error_code(error_code: int, signal_name: String) -> void:
	if error_code != OK:
		print("Failed to connect " + signal_name)


func positive_mod(value: int, divisor: int) -> int:
	var result = value % divisor
	if result < 0:
		return value + divisor
	return result
